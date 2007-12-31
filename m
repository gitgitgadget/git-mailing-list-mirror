From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 31 Dec 2007 21:26:21 +0800
Message-ID: <46dff0320712310526l2b801ed7xc52b7aae2d65048e@mail.gmail.com>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com>
	 <20071230215008.GB20098@efreet.light.src>
	 <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com>
	 <20071231093152.GC20098@efreet.light.src>
	 <46dff0320712310222m64d86e95l1499a7ffb1fff65c@mail.gmail.com>
	 <20071231105514.GA9214@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Dec 31 14:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9KfJ-0006xp-1R
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 14:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXLaN0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 08:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbXLaN0X
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 08:26:23 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:61177 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbXLaN0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 08:26:22 -0500
Received: by hs-out-2122.google.com with SMTP id 54so3098921hsz.5
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 05:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uV/6Q7l9SL6GbkCXgUsVazaSfNd+qP6OuxuasHsayOU=;
        b=vMsd8gtZUm+126AiDvh7Knc19ZqPE2zv0XGBuG/dEXditeA9bDrkQya79/DsrI2lqb+cJHbNxFTXv4jTNZnnq8/v5rrXif0zclg6T0hMd7B37RE3M7aZPqCaxuAIyd7uzQ3JBo+QdUHtZFGBwPF2ZcLrg5pyboXqTYNFCD34DL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4Td+ixY+s9RqmtQ5AWcMA8w688rOLi4aJ16BKGgcgsiZI/Gbc6gSzf2Nez4QLeLJS2VFLMutW1aFPxld30hrSSTGQnlyJ+MW/l0UbRDZ38+EwqcH5Nzolma2b2/dMn1RsDWCuAJks2jbl2MpgiGhgf2y38zELk2npLkx1tk+Sw=
Received: by 10.150.97.20 with SMTP id u20mr1279014ybb.17.1199107581265;
        Mon, 31 Dec 2007 05:26:21 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 31 Dec 2007 05:26:21 -0800 (PST)
In-Reply-To: <20071231105514.GA9214@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69403>

On Dec 31, 2007 6:55 PM, Jan Hudec <bulb@ucw.cz> wrote:
> On Mon, Dec 31, 2007 at 18:22:37 +0800, Ping Yin wrote:
> > On Dec 31, 2007 5:31 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > > On Mon, Dec 31, 2007 at 13:08:05 +0800, Ping Yin wrote:
> > > Note, that while you don't know the commit sha1 before the commit, you do
> > > know the *blob* sha1s. So you can do this change in pre-commit hook.
> >
> > I chose post-commit because i used commit sha1 instead of blob sha1 as
> > file version in the first time, and now pre-commit seems better. One
> > more question,  I use 'git ls-files' to fetch the blob sha1, so is the
> > got sha1  the same when pre-commit and post-commit?
>
> Yes, it should be.
>

Good news. So pre-commit is actually the right choice.

>
> Note, that you can -- and should -- add the foo.css to the commit. But the
> file might contain other changes in tree, that are not about to be commited,
> so prefered way would be to get the content from the index, modify that and
> update the index manually (with git update-index).

If pre-commit has modified files to be commited, it will abort this
commit and give a message to direct the user to commit again
with/without the changed content.

AFAIK, git add -i can add selected chunk to the index. As you said,
can git-update-index also do this job?




-- 
Ping Yin
