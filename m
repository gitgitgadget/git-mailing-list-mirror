From: "Brown, Len" <len.brown@intel.com>
Subject: RE: needs merge
Date: Sat, 7 Jan 2006 05:33:06 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1336F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 11:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBNr-0005it-C4
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWAGKdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWAGKdN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:33:13 -0500
Received: from fmr14.intel.com ([192.55.52.68]:10397 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030398AbWAGKdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 05:33:12 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k07AX8UK024811;
	Sat, 7 Jan 2006 10:33:08 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k07AX47Q026568;
	Sat, 7 Jan 2006 10:33:08 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006010702330816487
 ; Sat, 07 Jan 2006 02:33:08 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 7 Jan 2006 02:33:08 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 7 Jan 2006 02:33:08 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: needs merge
Thread-Index: AcYTdWqbURxdIkCXQ9KqWSJQW73gbwAADmLg
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 07 Jan 2006 10:33:08.0424 (UTC) FILETIME=[C0413C80:01C61375]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14254>

yes, it did the right thing to the source.

as a user, "cute" isn't the first word that comes to mind:-)

thanks,
-Len 

>-----Original Message-----
>From: git-owner@vger.kernel.org 
>[mailto:git-owner@vger.kernel.org] On Behalf Of Junio C Hamano
>Sent: Saturday, January 07, 2006 5:29 AM
>To: Brown, Len
>Cc: git@vger.kernel.org
>Subject: Re: needs merge
>
>Len Brown <len.brown@intel.com> writes:
>
>> however, when i then merged that branch into another there seem to
>> be some phantom conflicts on the very same files.
>
>First of all, does the final merge result look correct, without
>conflict markers?  I've slurped from your tree and tried the
>merge myself and it seems that both branches and the merge
>result of these branches have the conflicting path the same way,
>so I think it did the right thing for you, but I am just trying
>to make sure.
>
>> Do I understand all this output to mean that git attempted two
>> different merges, and discarded the 1st attempt in favor of 
>the second?
>
>Not really.  This is Fredrik's "recursive" merge in action.
>
>acpica (ed03f4) is merged into test (e3627f), but these two
>branches have criss-cross merge history and there are two
>equally valid common ancestors, 0aec63 and ed349a.
>
>What it did was first to find a merge between these two common
>ancestors, during which it found conflicting merge on those
>paths.
>
>It then used this merge result (with conflict markers still in
>them!) as the "virtual common ancestor" to merge the ed03f4 and
>e3627f commits; because both branches have resolved the
>conflicting part the same way earlier, this three-way merge
>cancels out the part that are marked with conflict markers in
>the virtual common ancestor (this is the cutest part of Fredrik
>merge algorithm).
>
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
