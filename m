From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: Best way to merge two repos with same content, differenthistory
Date: Fri, 5 Jun 2009 14:06:25 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117DCB@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com> <robbat2-20090605T183716-227340397Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:07:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCekl-00046t-MN
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZFETGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbZFETGa
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:06:30 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:26140 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbZFETGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 15:06:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <robbat2-20090605T183716-227340397Z@orbis-terrarum.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Best way to merge two repos with same content, differenthistory
Thread-Index: AcnmDnSeuoR6cWmFSkS3GcEge92nIwAAXiaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120819>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Robin H. Johnson
> Sent: Friday, June 05, 2009 1:46 PM
> To: Git Mailing List
> Subject: Re: Best way to merge two repos with same content,
> differenthistory
> 
> On Fri, Jun 05, 2009 at 12:10:30PM -0500, Kelly F. Hickel wrote:
> > Bost,
> > 	Thanks, but I'm already working with a local copy of the CVS
> repo.
> > 	I've corresponded with Michael Haggerty about the time this
> takes,
> > 	and there just doesn't seem to be any way to improve the speed,
> > 	without making some fairly drastic changes to cvs2git.
> I've been working with mhagger lately as it also pertains to the
Gentoo
> conversion. We've made some very good progress.
> 
> A couple of comments in that regard:
> - Make really sure your box is not short of RAM. Throw some
measurement
>   tools onto there to see it. A couple of GiB is worthwhile. After we
>   found this early on, and switched boxes, we dropped from our initial
>   multiple days to 20 hours.
> - His latest ExternalBlobGenerator code (_NOT_ available in SVN yet)
>   reduced our pass1 time from 36204 seconds to 1598 seconds, with
>   a potential to be much faster now, as parallelization of part of
that
>   is now trivial.
> - pass9 is still the remaining large time-eater for us. I've started
to
>   look at it, but I haven't made any actual developments yet.
> 
> Would you mind posting your cvs2svn stats like these?
> http://archives.gentoo.org/gentoo-
> scm/msg_b69b2f6ecee0ec7bb402d31b372b945b.xml
> 
> --
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

Robin, 
	That's all good news, I have an 8 way box with 32gb of ram
running a 64 bit Linux, a box with 4 gb of ram panics during the
conversion.

My conversion data is below...

Thanks,
Kelly


cvs2svn Statistics:
------------------
Total CVS Files:             18488
Total CVS Revisions:        225208
Total CVS Branches:       15203751
Total CVS Tags:           39079236
Total Unique Tags:           11453
Total Unique Branches:        4364
CVS Repos Size in KB:      3355895
Total SVN Commits:           49967
First Revision Date:    Mon Nov  8 02:26:51 1999
Last Revision Date:     Wed Apr 22 17:59:44 2009
------------------
Timings (seconds):
------------------
251546   pass1    CollectRevsPass
     4   pass2    CleanMetadataPass
   142   pass3    CollateSymbolsPass
 53491   pass4    FilterSymbolsPass
     4   pass5    SortRevisionSummaryPass
   163   pass6    SortSymbolSummaryPass
  8825   pass7    InitializeChangesetsPass
   418   pass8    BreakRevisionChangesetCyclesPass
   418   pass9    RevisionTopologicalSortPass
  4256   pass10   BreakSymbolChangesetCyclesPass
  4914   pass11   BreakAllChangesetCyclesPass
  4575   pass12   TopologicalSortPass
  3111   pass13   CreateRevsPass
   270   pass14   SortSymbolsPass
   154   pass15   IndexSymbolsPass
  5517   pass16   OutputPass
337808   total
251783.89user 80800.42system 93:50:11elapsed 98%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (3major+3132264023minor)pagefaults 0swaps


git-fast-import statistics: 
---------------------------------------------------------------------
Alloc'd objects:     415000
Total objects:       410079 (   2628078 duplicates                  )
      blobs  :       152002 (     68715 duplicates     135125 deltas)
      trees  :       213636 (   2559363 duplicates     164052 deltas)
      commits:        44441 (         0 duplicates          0 deltas)
      tags   :            0 (         0 duplicates          0 deltas)
Total branches:       15822 (      6184 loads     )
      marks:     1073741824 (    265158 unique    )
      atoms:          14807
Memory total:         32402 KiB
       pools:         16192 KiB
     objects:         16210 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =     311525
pack_report: pack_mmap_calls          =      13303
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =  403041230 /  403041230
---------------------------------------------------------------------


git repack -a -d -f --depth=4000 --window=4000 && git pack-refs --all
Counting objects: 409458, done.5/119582)   
Compressing objects: 100% (119582/119582), done.
Writing objects: 100% (128713/128713), done.
Total 128713 (delta 82330), reused 0 (delta 0)
Compressing objects: 100% (384171/384171), done.
Writing objects: 100% (409458/409458), done.
Total 409458 (delta 309214), reused 0 (delta 0)
