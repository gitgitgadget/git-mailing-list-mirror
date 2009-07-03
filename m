From: "Nick Edelen" <sirnot@gmail.com>
Subject: [RFC/PATCH INTRO] rev-cache
Date: Fri, 03 Jul 2009 16:13:25 +0100
Message-ID: <op.uwhy8lhktdk399@sirnot>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Sam Vilain" <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <exon@op5.se>, "Jeff King" <peff@peff.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 17:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMkSv-0005qe-84
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 17:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbZGCPNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZGCPNh
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 11:13:37 -0400
Received: from mail-ew0-f215.google.com ([209.85.219.215]:58426 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZGCPNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 11:13:36 -0400
Received: by ewy11 with SMTP id 11so1142634ewy.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from:cc
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=rpcE13pkAViGD44Qs3BKpWbowh5MPJa5q6UXw9Sc8tk=;
        b=jHpR/r/7Mm5APpuRV1QWRcDW4+e8tID2ISNyo+4qhqnAHGzEJs/Nh5asQy5LJbboKR
         wagTTyy2+6ay/0ZlsZuX8OFiWaYQTeJza97rbf+1stFkssrGkb6GMttEhQ71aeIsFBVf
         uv6MU4hY+ziRZcOLCZzIeuWo5OsexqWugcZ98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:cc:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=Q9AeNlus1bwShCpEjvx7kCCWmMwmHML06pN7V6SuFM2hbc6MDI25LFZgcEA0sF7iLF
         Cz+R0GPllcmWPKh6BVtqXCYfeOsX6jBWbrxN00egqMcVVkBjcxUDBkvXGg/ERsjjaYhp
         MrdsdaLZmhFUcX43Dsre73sFcG/WR96I4ZvQ8=
Received: by 10.210.20.6 with SMTP id 6mr1082151ebt.73.1246634019016;
        Fri, 03 Jul 2009 08:13:39 -0700 (PDT)
Received: from sirnot (resnet-nat-217.ucs.ed.ac.uk [194.81.254.217])
        by mx.google.com with ESMTPS id 28sm5572315eyg.4.2009.07.03.08.13.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 08:13:38 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122698>

Hi everyone, 

I've been working on a revision caching system (with gsoc), and would be curious to get some feedback on it and it's (potential) installation into git.  I believe the core mechanics of it are largely finished, but integration is still rather rough.  I've tried to divide it into 4 self-contained patches -- each representing a working implemenation with incremental featuresets.  The patchset is seperated as:
 * basic - the simplest working revision cache implementation, with full docs and relavant tests
 * objects - non-commit object caching + tests
 * misc - extra (maintenance) features and refactor of object caching (requiring slight modification of some object structures)
 * integration - (proof of concept) integration of rev-cache into rev-list, along with extensive tests

I'm afraid the first patch is rather big, as the topo-data encoding scheme is a smidgen complicated, but its effect on git's internals is very small -- it's less of a patch and more an addition of a few files.  I know you guys prefer inline patches, but in view of the patchfile size I decided it'd be more prudent to include that seperately as an attachment.  The only other caveat I can think of is that the tests currently require python, although that could change in future.

So yeah, I hope you find it interesting.  Apologies if I'm breaking protocol...

 - Nick
