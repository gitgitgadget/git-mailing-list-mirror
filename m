From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: How do I label conflict blocks in merge-recursive output?
Date: Fri, 29 Jun 2007 23:28:49 +0900
Message-ID: <20070629232849.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 16:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4HVB-00060W-Hf
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 16:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332AbXF2ObJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760475AbXF2ObI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 10:31:08 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:57437 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758332AbXF2ObG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 10:31:06 -0400
Received: from fe0.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5TEV5cq014890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 07:31:05 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:date:subject:message-id:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=hBAW8z7WNN9MY45keVGvbyHI0kDfqumNlH/HeD1bstWJ5PVAgs5esp9TdaQWlJ+eZ
	AAhJP/Y2wICr4OMiOIRBku2w+zKIbBHA1yzp8/RK4O3MRw5JHVK4XDpyNH4jpbZ
Received: from nanako3.mail.bluebottle.com ([222.221.254.163])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5TEUifN026415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 07:31:03 -0700
X-Trusted-Delivery: <7d0911a4674fe87143d10c1235d2616d>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51177>

Hi, I am updating my 'git-save' script and have a question.  

When I play back the state previously recorded, I run:

   $ git-merge-recursive $base -- HEAD $stash

This is done after getting the $base (the state the stash was made from),
and $stash (the state of the interrupted work recorded in the stash) in
these variables.  When there are conflicts, I see '<<<<<<<' and '>>>>>>>'
markers in the merged file.

A trouble I am seeing is that there are large hexadecimal string after
these markers, like this:

   <<<<<<< 13bd5d46b4a5d4ef44c53fab11e74801c18b16d0:A
   side
   revision
   =======
   local
   modification
   >>>>>>> 9aa4ad6a3bdf5340bed969f6e14abb4e07e794f7:A

I do not know what object these are, and I do not think it is useful to
show them to the user.  I want them to say something more useful.

In a real conflict after a 'git-pull', I think I saw nicer labels that are
not hexadecimal strings after these markers.

How do I tell merge-recursive to do that?  I tried to read the
documentation for merge-recursive but there is no manual page.

TIA

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com
