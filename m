From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC with a proof of concept PATCH] Add Bonsai-like query options 
	to gitk
Date: Mon, 23 Mar 2009 11:56:59 -0600
Message-ID: <51419b2c0903231056h4eef8d6cgef42f38bb21db1d5@mail.gmail.com>
References: <1236627747-32107-1-git-send-email-newren@gmail.com>
	 <18887.24393.595519.320173@cargo.ozlabs.ibm.com>
	 <51419b2c0903231054g621787b6i8537b8e0d5bf121d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 18:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LloQ1-000146-Ce
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 18:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbZCWR5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbZCWR5E
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 13:57:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:58816 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbZCWR5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 13:57:01 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2198316yxl.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=35XMDVJpzndb8iiMmWRMPNWbcj1UZScyTV1qep+4X5o=;
        b=lihzol+Smmw96cgAQs4iX8czr+QtYGN8mhm8vnSNV2Ly1CoUXmtDJxDLgKT5ZusNoE
         XYIrIKlzKWbgDm9rzDvXRTnCHWLZlgU8vIdoHsG2SOF7AY2R4b5Y0U2GATaEofN7/5VK
         xNKmgR37/8Zv5kdStaAOwpCJZm+OJ9ZZARsu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kf2OqWcaY8+9f7Eph1TJe298EVp3DX2rGDRbCBlY/bSXR7XDwo738vlORWP1TcBVcs
         Kqi84CudC8MDQg4OdCf9Ug94c6xUl5F47i7I6DiNnWFcnEO0evmetMoQj3X6XL8vXGTl
         c6QnjELFa1KPjkNLTYL0cONDjoCN26yplaxe8=
Received: by 10.231.15.202 with SMTP id l10mr1889527iba.35.1237831019060; Mon, 
	23 Mar 2009 10:56:59 -0700 (PDT)
In-Reply-To: <51419b2c0903231054g621787b6i8537b8e0d5bf121d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114338>

(Sorry, resending my own email since I accidentally left of the cc's.)

On Mon, Mar 23, 2009 at 4:07 AM, Paul Mackerras <paulus@samba.org> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> (If you like screenshots, I've got some before & after ones up at
>> http://www.gnome.org/~newren/temp/gitk/gitk-edit-view.html, but
>> remember that this is just a proof of concept and call for comments.)
>
> Looks reasonable... have you developed the patch any further?

Yes, I have.  There was a cosmetic tweak or two, but the main change
was fixing the view remembering stuff that I noted I broke in the
original patch.  I've also showed this modified dialog in two
different git presentations, to dozens of new and potential users of
git, and it seems to have been well received[1].  I'll send a
follow-up patch shortly (I'd copy it inline, but I'm afraid gmail will
screw it up).

Elijah


[1] For one of the two groups, a lack of a Bonsai replacement actually
derailed their conversion to svn about a year ago.  This group was
very interested in git after my presentation and seemed satisfied with
gitk (with my proposed changes) as a replacement for Bonsai.  There
was one minor question that did come up each time -- one person in
each presentation asked why it is that when you specify --author=smith
(at the command line or via the equivalent box in the gui), you also
see commits authored by e.g. "jones" in gitk; however, once I
mentioned the different colored dots in gitk and the fact that it's
showing the commits that the patches are relative to, there was no
more issue and everyone was happy.  I'm guessing it'd be slightly more
intuitive to them to have gitk filter out these parent commits from
the graph unless they also meet the search criteria, but it's a pretty
minor issue.
