From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 20:24:53 +0100
Message-ID: <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTduV-0006i6-N3
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 20:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760116Ab2JaTYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 15:24:55 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58469 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab2JaTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 15:24:54 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1818050oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8TL6P4DpajhoRaYfg7+xDnmKVp++/YfeqqlxlW29Noc=;
        b=UXpDA0XYtI1BVUXprFerPCrjnfw10VKBW9YwvFdRWkwpjNVprjz5vRHGis2oZWMMPQ
         0OUfgx55l7LzVw3wv3X3YFhCbG9yKK3HjP2/R9QFcU23DWWkBc5uDnwNwURzedlir/53
         +GqmvgWn0Gjc4/MVRrpr/HoEqsW79dqQDHlbRYxxw8OXyyujSvgMvNjX4iyZ7UNWv5d4
         UWgtepn6AzJSPNEce/SOR+nogocbP02zsH+xqZg96pLpepnfFzGbOWb2IeSsCwyjLCcU
         8ffK9bVcq4BuI9NTMieBJyKwI5/9G4afp7TJBYMUXWSrmp377e67zVI0yN8JUqyaY5uB
         gVRA==
Received: by 10.60.32.5 with SMTP id e5mr13468113oei.46.1351711493707; Wed, 31
 Oct 2012 12:24:53 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 12:24:53 -0700 (PDT)
In-Reply-To: <20121031185903.GA1480@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208850>

Hi,

On Wed, Oct 31, 2012 at 7:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, Oct 31, 2012 at 7:20 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>
>>> I just tested this with junio/next and it seems this issue is still
>>> unfixed: instead of
>>>
>>>         reset refs/heads/blub
>>>         from e7510461b7db54b181d07acced0ed3b1ada072c8
>>>
>>> I get
>>>
>>>         reset refs/heads/blub
>>>         from :0
>>>
>>> when running "git fast-export ^master blub".
>>
>> That is not a problem. It has been discussed extensively, and the
>> consensus seems to be that such command should throw nothing:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/208729
>
> Um.  Are you claiming I have said that "git fast-export ^master blub"
> should silently emit nothing?  Or has this been discussed extensively
> with someone else?

Maybe I misunderstood when you said:
> A patch meeting the above description would make perfect sense to me.

Anyway, when you have:

% git fast-export ^next next^{commit}
# nothing
% git fast-export ^next next~0
# nothing
% git fast-export ^next next~1
# nothing
% git fast-export ^next next~2
# nothing

It only makes sense that:

% git fast-export ^next next
# nothing

It doesn't get any more obvious than that. But to each his own.

Cheers.

--
Felipe Contreras
