From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/4] format-patch: improve head calculation for cover-letter
Date: Sun, 7 Apr 2013 03:36:23 -0500
Message-ID: <CAMP44s1tHdqKmMJbc6_zwEFZ-bK_boSX5zBu1zeBizJ8QVh2uw@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-3-git-send-email-felipe.contreras@gmail.com>
	<7vbo9q93u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 10:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOl5l-0004m1-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 10:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161544Ab3DGIgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 04:36:45 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45659 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab3DGIgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 04:36:24 -0400
Received: by mail-lb0-f177.google.com with SMTP id r10so4794056lbi.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EVlDPdX11b/i+h5J28bujeu6K29ZSEyH4DXqzfUk4zE=;
        b=RM2GGSTK1Pw7R78S+bc0GrShnexbNLBcDXYrmLRuglKumTSPboKkWiOWqXlchjTvBw
         bieJG+XBzVVYAdGp3r3If9N4ZpbzkaqEW7HQv6jzRteneuAAXFcbq/CyoqGlcHKkIPQx
         vGDtG5L9f29/mjC4e6Z0y5P24sPkXQxwLrQkZMjDG1QPe2ibzo4pezryEPqeviX35dPj
         CyRxUay/L7l+pBgY3FfRhkDf5mwiOZ8l26UeDy0NMh7mMjzg6qixaxsgmCJy68BU1lhx
         MSJwIAxVfxZiUMVx827MdB9x++ObP2GzzflDMPAfLUAu55tbjqS43F/40hXFwaabAxIT
         2x9Q==
X-Received: by 10.152.128.98 with SMTP id nn2mr9577794lab.17.1365323783147;
 Sun, 07 Apr 2013 01:36:23 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 01:36:23 -0700 (PDT)
In-Reply-To: <7vbo9q93u2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220296>

On Sun, Apr 7, 2013 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If we do it after the revision traversal we can be sure that this is
>> indeed a commit that will be processed (i.e. not a merge) and it's the
>> top most one (thus removing the NEEDSWORK comment).
>
> There may not be a single top-most one anyway (which is what that
> "randomly pick" comment refers to and punts), so taking the tip
> after traversal is just as good as doing it before.  So this is a
> good change, but it still is punting.

Yeah, I thought of looking at 'git diff' and do the same thing, but
then I realized 'git diff --stat' has the same issue, so I don't think
it really matters.

-- 
Felipe Contreras
