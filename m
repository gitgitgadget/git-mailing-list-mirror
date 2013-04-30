From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 01:10:06 -0500
Message-ID: <CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3lY-0004Qq-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3D3GKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:10:09 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:47840 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3D3GKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:10:08 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so142042lab.16
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jmlcmyr5MqUjTVRQ9boch7/WV2/xsNhHGkH5so0PT7A=;
        b=YsvmAkV63gq+kmrzi8nU6kM1ZFYg/u957wf7ThPSaWUl8kRsMxWiIZaoTVo2aHfznr
         FvmlYjxjV4flqj/kHTQBTFIAeOtBifGfMMhsT314UTObMYJ1EoNyGMGaFWIoOqVp6gAL
         U8bCQgTcIndcmwhCHIvuT7jdI7EN64cMriLZkiZy+yXcxMyG+F1w9nZsOUgw1f7bGw4E
         EstzskJUOU8PIqL6bZW24iWLfDP7KYiQdh5jTd7pEwxBlVYeJkHKNPu+cPbAIsFXfMv3
         rvN9q0G1ypBzpB1ks9NTNvQjlb1RKQSH90IDxD1XZIKnSpZcDeGc9BNpLW59BEaRHtaw
         GnFg==
X-Received: by 10.112.22.198 with SMTP id g6mr24173772lbf.135.1367302206514;
 Mon, 29 Apr 2013 23:10:06 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 23:10:06 -0700 (PDT)
In-Reply-To: <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222910>

On Tue, Apr 30, 2013 at 12:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>> use 'git show @~1', and all that goody goodness.
>
> I like this. I haven't spent a lot of time on thinking about
> ambiguation. But I think we're safe there. '@' is not overloaded much
> like ':', '^' or '~'.
>
>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>> 'master@'.
>
> I'm a bit reluctant to this. It looks like incomplete syntax to me as
> '@' has always been followed by '{'. Can we have the lone '@' candy
> but reject master@ and HEAD@? There's no actual gain in writing
> master@ vs master@{0}.

That's what I tried first, but it just didn't feel elegant to have one
check for this case only. foo@ does follow naturally, and it doesn't
hurt.

>> +'@'::
>> +  '@' alone is a shortcut for 'HEAD'
>> +
>
> And this does not explain about HEAD@ or master@. But because I prefer
> the candy part only. This documentation part looks good :)

Yeah, there's no point in documenting things that are not useful for
the user. The fact that HEAD@ is translated to HEAD is just an
implementation detail.

-- 
Felipe Contreras
