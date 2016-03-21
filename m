From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Mon, 21 Mar 2016 18:53:19 +0100
Message-ID: <CAP8UFD1_mxej3YE_vU7DaXEsDpu-VA1YZtG5zkhLE2NXHpfL+Q@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	<alpine.DEB.2.20.1603201628590.4690@virtualbox>
	<CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
	<alpine.DEB.2.20.1603210814410.4690@virtualbox>
	<CAFZEwPNd3X9JocrrJa-d4mV-U_MZdMEq=gMxByZ9iQd6Tz4w2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:53:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai418-0007hq-DO
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbcCURxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:53:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36380 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387AbcCURxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:53:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so23723521wml.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+A/VTmrlldltAEeNfc7UtXac1PSz4Kkm+f+UIKnmas0=;
        b=xOl/PKzXB22+PXmB9oQOR1wg1v+fdfnO6cXkJ2ZH0LA9J/Ol8qT1rp8ASRg6NQi3xX
         JmFi7I3JWiQRgUEvGx36nFqvgOrKxFOugDCX3VLWUUti3FXQ9yJ2KLZtMA8qfQplbDf+
         03ML2LkMpnMT6X7Z81vw8HFAX3fTachy7ECSYMSdbcmtosS6m3wmlMMFjke9etPVNn1a
         xqLK3QgR/Xqe+1fyTJA5BP13+vNCpM2wWEN2gqtGnq3kX0I+mn3F13wlQCDdYkdIUSQy
         pcu0m/FAax9HowZcVpzcDZ9cGA0H9/MtXBKzfkA8EBcd67zB9S9oYLSG/+ICQMOjvjI7
         EJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+A/VTmrlldltAEeNfc7UtXac1PSz4Kkm+f+UIKnmas0=;
        b=MmRmdIuwklscq6C+hxqFAkqeXrW9xe4xpeZEugk2w5uaZcpJoN5oZFEz7F1OcCiicg
         wJM+IGslJkiHcQKjQSHSgOdBag30oGU/FglVJHO37pSl5qeXkiXyinURDYMINzQHtAVc
         GYTppppqcMIbBCFhSatuEnxDMfzAuViu5faEe+e7zq7Cz5brA0AST/ANqaQjKRn6PsQh
         GLNSen3jSWL9KgB22MqmfeyMxqRuZToPunwa/Ma6UxlwMr5p7CW6QMg6OFBCPQbn/nkQ
         Q7mwnKD6rMhPQq7G3+VEQP3137oUmEOjrMepgojDogBUwLEvAMz70q0956SAMgofHwTH
         m8VA==
X-Gm-Message-State: AD7BkJJG7KSPm+R8DBoF+zKg77QGC3VUWq8J3PDr/aW/iNq/0J34/wotbJSXUs3j2OKFw8rjLmPaU2ihesbpkA==
X-Received: by 10.28.147.72 with SMTP id v69mr14502896wmd.79.1458582799436;
 Mon, 21 Mar 2016 10:53:19 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Mon, 21 Mar 2016 10:53:19 -0700 (PDT)
In-Reply-To: <CAFZEwPNd3X9JocrrJa-d4mV-U_MZdMEq=gMxByZ9iQd6Tz4w2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289429>

Hi Pranit,

On Mon, Mar 21, 2016 at 8:29 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Mon, Mar 21, 2016 at 12:48 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Pranit,
>>
>> On Sun, 20 Mar 2016, Pranit Bauva wrote:
>>
>>> I could first move individual functions to bisect--helper.c.
>>
>> My suggestion would be to give it a try already with some functionality
>> you deem small enough to move to the bisect--helper within a day or so. It
>> is always good to test the waters like that, and to include this early
>> work in the proposal, also to assess (and to let the reviewers assess) how
>> feasible the project is.
>
> Sure! I will start with check_term_format().
>
> Also, I think implementing a new algorithm for bisect along with this
> would be too big for a GSoC project

Yeah, I also think so.

> and I am no algorithm expert. I
> will stick to --first-parent along with incremental rewrite.

My opinion is that an incremental rewrite by itself is big enough for
a GSoC. And it might be difficult to do something else that is bisect
related at the same time. So if you want to do the rewrite, just focus
on it. If you ever have some time left we will easily find other
interesting bisect related improvements.

If you really want to do "--first-parent" then you should probably add
"Improve git bisect terms" to it in your proposal.

Best,
Christian.
