From: Markus Elfring <Markus.Elfring@web.de>
Subject: Challenges for an octopus merge
Date: Thu, 10 Feb 2011 15:30:44 +0100
Message-ID: <4D53F694.1060105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 15:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnXZC-0003MQ-HB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 15:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1BJOcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 09:32:13 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:51940 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab1BJOcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 09:32:12 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5C773196E4F01
	for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:31:14 +0100 (CET)
Received: from [78.48.201.189] (helo=[192.168.1.46])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PnXYA-00031p-00
	for git@vger.kernel.org; Thu, 10 Feb 2011 15:31:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+xdpgPa2rgnt5LKacHH8uNDooyqbp+98zVu9Es
	1xGaWr4frPbfyvk/qvKfqxPGKrAftfRt9cPVEOS/Tr7UYVfw8X
	47/jv4Lha4EkOYrZaz4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166485>

Hello,

I have got an update history like the following in a local repository with ten 
patches in separate topic branches on my openSUSE 11.3 system.

master -> tag: v3.0 -> compilation_maintenance
               /->  errno => C1
              /->   braces => C2
             /->    string => C3
            /->     binary_search => C4
  -> route1 --->    temporary_files => C5
            \->     make_functions_static => C6
             \->    const-correctness => C7
              \->   signal_handling => C8
               \->  enum => C9
                \-> double_declaration_deletion => C10


elfring@Sonne:~/Projekte/BtYacc/lokal2> git --version && git checkout -b test3
git version 1.7.3.4
Switched to a new branch 'test3'
elfring@Sonne:~/Projekte/BtYacc/lokal2> git merge --no-ff --stat --verbose --log 
-m 'Combination of six topics' errno braces string binary_search temporary_files 
make_functions_static
Fast-forwarding to: errno
Trying simple merge with braces
Trying simple merge with string
Trying simple merge with binary_search
Trying simple merge with temporary_files
Simple merge did not work, trying automatic merge.
Auto-merging defs.h
Trying simple merge with make_functions_static
Simple merge did not work, trying automatic merge.
Auto-merging defs.h
ERROR: content conflict in defs.h
Auto-merging main.c
Auto-merging mkpar.c
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.


The merge description (suggested commit message) was fine in the display of the 
tool "Git GUI 0.13.0" (Tcl/Tk version 8.5.8).
I delete the conflict section in the header file "defs.h" completely.


elfring@Sonne:~/Projekte/BtYacc/lokal2> git merge --no-ff --stat --verbose --log 
-m 'Combination of four topics' const-correctness double_declaration_deletion 
enum signal_handling
Trying simple merge with const-correctness
Simple merge did not work, trying automatic merge.
Auto-merging defs.h
Auto-merging output.c
Auto-merging reader.c
Trying simple merge with double_declaration_deletion
Simple merge did not work, trying automatic merge.
Auto-merging mkpar.c
ERROR: content conflict in mkpar.c
fatal: merge program failed
Automated merge did not work.
Should not be doing an Octopus.
Merge with strategy octopus failed.


The merge description was missing (no commit message) in this case.
Is this omission acceptable?

I have also got the impression that the corresponding source files did not 
contain enough conflict markers.
Is my use case relevant for further considerations of details with this merging 
process?

Regards,
Markus
