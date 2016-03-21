From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Mon, 21 Mar 2016 23:43:46 +0530
Message-ID: <CAFZEwPO-cw2LOBh50uRbjRe-44XVC59Www=qygx5ABQG8f4N-A@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	<alpine.DEB.2.20.1603201628590.4690@virtualbox>
	<CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
	<alpine.DEB.2.20.1603210814410.4690@virtualbox>
	<CAFZEwPNd3X9JocrrJa-d4mV-U_MZdMEq=gMxByZ9iQd6Tz4w2Q@mail.gmail.com>
	<CAP8UFD1_mxej3YE_vU7DaXEsDpu-VA1YZtG5zkhLE2NXHpfL+Q@mail.gmail.com>
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
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:14:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai4L3-0003Ov-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 19:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757638AbcCUSNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 14:13:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35738 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631AbcCUSNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 14:13:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id d21so8416662ywe.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KVcJPACVm9E50omyml0law35f/P/sU54+ymndaHlx44=;
        b=i+wwiHZ0GdkYUFF+0Rg/CtLC71ffCVmT9f+qLHawJdi60hqC2De5j7h+wOL3Po2vA7
         uJBvyWIi9WSlf3VTFDtHOuXNrYZV3GbtMWKcEp9F9N8eyfNvkq3XRpjaFPu7hy+qGdEh
         f2RS204y748QPTwXRAgPtqEC17E/Ov+pF0xp5DSpU/q8XVTtYwoUmoYghRR7WlmJoQ+3
         tPnl/8XmtYiUCl0xHQ/R8gcCUgRkC/NnC7uzgy4n+ORbi0oQTmQDfkiAIVtrrS6Wf91V
         8mR5yPDN1UfJWnzKlJ136BzB51xH2kIUtJWZ8johdn2lF/G4PU7R9nE5zKjA0bh2Kdnl
         xwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KVcJPACVm9E50omyml0law35f/P/sU54+ymndaHlx44=;
        b=l7ClAtLGzqiRvkK1FeHVJo4beeXd2HKuP8JXIUzKRWAcBijugBNW28BcFYaJqEUwfA
         WBCERjcC16e2GKn0DFSvp2kejFq31HoZr4t2XXmL9gHHV7dI19Ouvq7450H4AbP8LKdw
         Ha7tCwQchtirdU4eX9JewmM1X6S8Pqnsw5ugaMQgD1bN/cy8MmFZWP3b/IX5t5VdF25f
         b7ifBiVM132Eq3P1+DspFEC1k8bp9ouUwOKznsZgCGWPTuzf9fGFM7t/i77oZVRG7ckw
         BHI4KpwUbMkfVWsUPoVcJTVpGpiLQWDerdvXq7JwnYWaO9qdrKupc08dR5Oo6okm9zR1
         G9+w==
X-Gm-Message-State: AD7BkJLO8MalN1F+3KOFLUjU3IntLxVhqmDSWh6P1J0SoG+kGLFpgebOtNDyCrAKlEAgnpnqW5qtXmqepjKu+g==
X-Received: by 10.37.12.195 with SMTP id 186mr15049665ybm.154.1458584026221;
 Mon, 21 Mar 2016 11:13:46 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 21 Mar 2016 11:13:46 -0700 (PDT)
In-Reply-To: <CAP8UFD1_mxej3YE_vU7DaXEsDpu-VA1YZtG5zkhLE2NXHpfL+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289433>

On Mon, Mar 21, 2016 at 11:23 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi Pranit,
>
> On Mon, Mar 21, 2016 at 8:29 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Mon, Mar 21, 2016 at 12:48 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Pranit,
>>>
>>> On Sun, 20 Mar 2016, Pranit Bauva wrote:
>>>
>>>> I could first move individual functions to bisect--helper.c.
>>>
>>> My suggestion would be to give it a try already with some functionality
>>> you deem small enough to move to the bisect--helper within a day or so. It
>>> is always good to test the waters like that, and to include this early
>>> work in the proposal, also to assess (and to let the reviewers assess) how
>>> feasible the project is.
>>
>> Sure! I will start with check_term_format().
>>
>> Also, I think implementing a new algorithm for bisect along with this
>> would be too big for a GSoC project
>
> Yeah, I also think so.
>
>> and I am no algorithm expert. I
>> will stick to --first-parent along with incremental rewrite.
>
> My opinion is that an incremental rewrite by itself is big enough for
> a GSoC. And it might be difficult to do something else that is bisect
> related at the same time. So if you want to do the rewrite, just focus
> on it. If you ever have some time left we will easily find other
> interesting bisect related improvements.

I just realised it after I finished rewriting a simple function. I
will send that patch. It would be much better on doing one thing
properly.

> If you really want to do "--first-parent" then you should probably add
> "Improve git bisect terms" to it in your proposal.
