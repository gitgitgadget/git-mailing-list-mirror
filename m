From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 7 Apr 2013 13:02:41 -0500
Message-ID: <CAMP44s1Pd_O8FmWy=bgzEDrbGQuNStn9=LSYF146VCGLby3F7g@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
	<vpqwqsefl9b.fsf@grenoble-inp.fr>
	<CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
	<vpqbo9qfh1y.fsf@grenoble-inp.fr>
	<7v38v25k8b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtvU-0008Sy-OC
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934158Ab3DGSCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:02:44 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:40862 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759906Ab3DGSCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:02:43 -0400
Received: by mail-la0-f45.google.com with SMTP id fn20so1291344lab.32
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3NSrjKuM4GkukTtyRReEhoP2SUIRZelINRC+CsmutY4=;
        b=CtiIG57gD+7aZ47jpTvjEylxTxdh5LJRoLEx4huYkJqzc5DkgX7Mo6SJHl8/MAfvcv
         YmSbuqsoZngFJ8MmHf92US4ySRZR/0i6aQNx+jYP9qXSbkF52rdI/ef7DOXKesNzeaBB
         MzLIStu4t5l53auWlV8F2/hzXg2HnT+wIrE75HD80A46+mkMHlYe50nKcpGl+z+6+uqh
         +6WM96snecyM8oS8y/cA9rMSldnfXCbHk+UQJ9Qz1l4UmLD+4rjIvPAKKFHh+T9biRWM
         jh5CU/EKFaedBpjSJhA60D1sA4fODhtZK1fWbmVb7cnglXJMqXv6yOXtUH03UUiMaSkM
         tJ5w==
X-Received: by 10.152.135.205 with SMTP id pu13mr10113142lab.48.1365357761990;
 Sun, 07 Apr 2013 11:02:41 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 11:02:41 -0700 (PDT)
In-Reply-To: <7v38v25k8b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220352>

On Sun, Apr 7, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> Wouldn't this work for both cases?
>>>
>>> % git -c format.coverletter=auto format-patch
>>
>> Then, what's the point in having a --cover-letter option?
>>
>> "git -c" is a good last-chance solution, but when we provide the same
>> feature as a command-line option and as a configuration option, I can
>> see no reason to add subtle difference between them.
>
> I do not see a good reason to resist consistency by suggesting a
> workaround.

There's no need for a workaround, because there's no use-case.

> We may do so ourselves when responding to an end user
> bug report "I cannot countermand X from the command line" as a first
> response "In the meantime you can work it around like so", but that
> is as you said a last-resort workaround and does not justify why the
> command line interface is lacking an obvious override.

The command line interface is not missing anything.

> But I think --cover-letter=auto I made was a bad suggestion.  An
> optional parameter to a command line option is generally bad, as it
> makes the parsing ambiguous [*1*], and turning what traditionally
> was a boolean without any parameter into one that takes an optional
> parameter is even worse.
>
> We should instead add this as a new feature, --auto-cover-letter, or
> something, i.e. the synopsis will have these as the choices
>
>     [--[no-]cover-letter|--auto-cover-letter]
>
> and the last one would win (e.g. "--cover-letter --auto-cover-letter"
> would mean "auto").

Well, go ahead and implement it, because I'm not going to waste my
time implementing something nobody will *ever* use.

-- 
Felipe Contreras
