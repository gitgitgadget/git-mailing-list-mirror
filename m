From: "Philip Oakley" <philipoakley@iee.org>
Subject: [GSoC] small project idea from my todo list.. Bundle Symbolic links
Date: Sat, 7 Mar 2015 16:22:16 -0000
Organization: OPDS
Message-ID: <0B989088FC644299B6707429908D1D1D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 17:21:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUHTy-0000j2-AH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 17:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbbCGQVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 11:21:36 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:60806 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbbCGQVf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 11:21:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BaWQDIJPtUPLW1BlxcgwUBAVEvK4ckq2uOdBGFaAEDAYEnTgEBAQEBAQUBAQEBOCAbhAoUAQEuHgEBLAIIAgEkOQEEGgYHAxobAgECAwEKiBgJoTGHRo5VlBeTI4EUBYo3hVBegwWHBDmLPoZegWgBCgEBAYIbPjIBAYJAAQEB
X-IPAS-Result: A2BaWQDIJPtUPLW1BlxcgwUBAVEvK4ckq2uOdBGFaAEDAYEnTgEBAQEBAQUBAQEBOCAbhAoUAQEuHgEBLAIIAgEkOQEEGgYHAxobAgECAwEKiBgJoTGHRo5VlBeTI4EUBYo3hVBegwWHBDmLPoZegWgBCgEBAYIbPjIBAYJAAQEB
X-IronPort-AV: E=Sophos;i="5.11,358,1422921600"; 
   d="scan'208";a="489470825"
Received: from host-92-6-181-181.as43234.net (HELO PhilipOakley) ([92.6.181.181])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 07 Mar 2015 16:21:33 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265001>

Hi folks,

This is one of my small/mini projects from late year that got pushed 
down my stack that may be suitable for someone on the GSoC small project 
list:

 - Embed symbolic link references into the Bundle processing.

Currently git bundle gets 'confused' when there are multiple refs using 
the same HEAD ref, with only a heuristic to guess which ref should be 
allocate to HEAD. The issue is to update the 'heuristic' process to get 
it right, while still being backward compatible.

A potential solution was identified in [1], and a similar problem (where 
does HEAD point to..) was recently covered in patch [2] (and discussions 
either side) .

I'd be quite happy for a GSoC candidate/student to have a go at it, 
especially as I've let it languish! ;-)
--
Philip

--
Essentially, hide the clues as to where the Symbolic refs point to 
(other symrefs) after a null char in the line format..

Perhaps also add a 'Rev #<n>' after the bundle's version line as well ?

[1] 
http://thread.gmane.org/gmane.comp.version-control.git/258827/focus=259087 
(addition of symref=refs/heads/master after a \0 null at the end of the 
refs line.)
[2] 
http://thread.gmane.org/gmane.comp.version-control.git/263922/focus=264936
[3] http://thread.gmane.org/gmane.comp.version-control.git/234053 has an 
older discussion regarding the same issue ('where does HEAD point to') 
on cloning. Linked from 
http://thread.gmane.org/gmane.comp.version-control.git/258365/focus=258463
