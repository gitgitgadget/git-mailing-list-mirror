From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix,
 argv) pair
Date: Thu, 10 Jan 2013 18:05:24 +0700
Message-ID: <CACsJy8Apu1BJ2t+vpbzpQ4Wni==Azzmp99a+TmBzR3h8qpx=8g@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-4-git-send-email-martinvonz@gmail.com> <7vy5g25f9b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:06:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtFxg-0001M6-7e
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 12:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab3AJLF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 06:05:56 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48253 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab3AJLFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 06:05:55 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so399566obc.18
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ThGFEOjpWSmZiYFy68PmXdkcgCAXrJA8HgRmzk25hwY=;
        b=sLVBSxo/EiZQr1/cKYBWKSdOW3IKTchwANAeNRP+jbE3fqlQPlHS3IjQS62jkDQKlH
         V50aPQv1JQBkNpFLnk/g4lV/+Wez5uRO165V5GoALfS46gPLP2eLgKNfO9r7o2svXK4V
         6zCQuFVzsvPy0bCn/+IFK22afgf6LvloxdnHuHrw5U8kV8zjMI+pojfs8SJ5ZQoIY1md
         IHmDjGfKLKQDbpbcXQmI+uSnijr3tTxkDkSe3kiDm9VHo/aIdPFi5wIqpCu82KGCzsXU
         FsJuyS6eLclkhJKsUiQ14Zw1fDkGz8LzLTfWGEG+UOgPdB9Nxf1MlhssCu74Y3/pWefS
         1paA==
Received: by 10.182.159.5 with SMTP id wy5mr50385144obb.31.1357815954556; Thu,
 10 Jan 2013 03:05:54 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 10 Jan 2013 03:05:24 -0800 (PST)
In-Reply-To: <7vy5g25f9b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213133>

On Thu, Jan 10, 2013 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> We use the path arguments in two places in reset.c: in
>> interactive_reset() and read_from_tree(). Both of these call
>> get_pathspec(), so we pass the (prefix, arv) pair to both
>> functions. Move the call to get_pathspec() out of these methods, for
>> two reasons: 1) One argument is simpler than two. 2) It lets us use
>> the (arguably clearer) "if (pathspec)" in place of "if (i < argc)".
>> ---
>> If I understand correctly, this should be rebased on top of
>> nd/parse-pathspec. Please let me know.
>
> Yeah, this will conflict with the get_pathspec-to-parse_pathspec
> conversion Duy has been working on.

Or I could hold off nd/parse-pathspec if this series has a better
chance of graduation first. Decision?
-- 
Duy
