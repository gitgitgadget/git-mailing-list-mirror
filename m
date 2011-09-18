From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: import utf16 file properly
Date: Sat, 17 Sep 2011 21:19:42 -0400
Message-ID: <20110918011942.GA13702@arf.padd.com>
References: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
 <4E705DF8.1040508@diamand.org>
 <CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
 <CANeU7QnPqJ+igcmS1JX_vasCXr+Wpcx2b4Z-sy_=0qKEkG+v_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Chris Li <git@chrisli.org>
X-From: git-owner@vger.kernel.org Sun Sep 18 03:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R563f-00049H-Qc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1IRBTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:19:46 -0400
Received: from honk.padd.com ([74.3.171.149]:49735 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab1IRBTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:19:45 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 1248CBFC;
	Sat, 17 Sep 2011 18:19:45 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 53BEE31448; Sat, 17 Sep 2011 21:19:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnPqJ+igcmS1JX_vasCXr+Wpcx2b4Z-sy_=0qKEkG+v_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181591>

git@chrisli.org wrote on Wed, 14 Sep 2011 11:39 -0700:
> On Wed, Sep 14, 2011 at 11:29 AM, Chris Li <git@chrisli.org> wrote:
> >> Does this change do the right thing with RCS keywords in UTF16 files?
> >
> > I don't know what is the rules about the RCS keyword in UTF16 files.
> 
> I did a little bit research and found this:
> 
> http://www.perforce.com/perforce/doc.current/manuals/p4guide/ab_filetypes.html
> 
> RCS keyword expand should only happen for "+k" or "+ko" modifiers.
> There for, "utf16" files without modifier should not be converted.
> In that regard, the patch is correct. But both the original and patched version
> did not handle "utf16+k" type of files. I still consider it as a separate issue.

Your patch looks good and this all makes sense.  I redid
it, adding a test case, and some more patches to clean up
some of the filetype detection code.  I'll send it out for
review soon here.

Luke:  thanks for the comments; they prompted me to think
about keywords and beyond.

		-- Pete
