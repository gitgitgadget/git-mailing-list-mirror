From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to mark a complete sub-directory assume-unchanged/skip-worktree?
Date: Fri, 28 Feb 2014 06:26:42 +0700
Message-ID: <CACsJy8DV2uCQbfCP=Mf2qajVAtpTZvKKeCS2H4_o6LA3B96QAA@mail.gmail.com>
References: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 00:27:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJAMH-0004K3-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 00:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaB0X1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 18:27:14 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:62692 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaB0X1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 18:27:13 -0500
Received: by mail-qg0-f47.google.com with SMTP id 63so7741985qgz.6
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3PAfyM/pbDy5sX0i3wcoBefbsByjCyL/OOu5jEJWgYg=;
        b=XS15ao74TzmAswdVbkcTxoonkYXO4QaRZow/xK4M6Z88q51QdmiOXzEAUGxWGZTv5L
         PrM548dP0Dbo6F4Q0H9Wa9HCglXTwHzQqFWG8a/PR0UZ+PABaO7QnKAIzPlkjLNbn/bT
         8fKBF7bMHK59VXZlh3tjaxluvGR2Lp8eG6lUVwRlPyhDg2nNj1TCKiGiF5CzkEhnunfs
         FhJZ6/hfylUd6hr90z9PwQ/ObAx+RKSdsXTkmigL7mGkmxvogg1goOqPbJIzcltq++Ri
         PxByUVkTC9AxWt/tbHDwATeOQBOpB7g7fEoInhvT6MAFv7YEP0+xEKtfKQEw9YGC7p1Z
         zC4A==
X-Received: by 10.140.107.138 with SMTP id h10mr11138725qgf.30.1393543632543;
 Thu, 27 Feb 2014 15:27:12 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 27 Feb 2014 15:26:42 -0800 (PST)
In-Reply-To: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242874>

On Fri, Feb 28, 2014 at 12:25 AM, Philip Oakley <philipoakley@iee.org> wrote:
> Have there been previous attempts to look at marking sub-dirs as
> --skip-worktree, or some other sentinel value for the missing tree?

I dealt with this by creating partial index, that only contains
entries for interested subtrees. The index also stores the base tree
SHA-1, so write-tree can still create (full) new trees correctly from
partial index.
-- 
Duy
