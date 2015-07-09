From: John Norris <john@norricorp.f9.co.uk>
Subject: Building git 2.4.5 on AIX 6.1 problems
Date: Thu, 09 Jul 2015 18:06:22 +0000
Message-ID: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGKp-0007du-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbbGISOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:14:01 -0400
Received: from avasout07.plus.net ([84.93.230.235]:39632 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbbGISN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 14:13:59 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2015 14:13:59 EDT
Received: from webmail.plus.net ([84.93.228.66])
	by avasout07 with smtp
	id qJ6N1q0081SbfYc01J6NLT; Thu, 09 Jul 2015 19:06:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=IdN6Ijea c=1 sm=1 tr=0
 a=C5+YawzV8SR07mwocaP9vA==:117 a=6JrruMomGWIwZufWOQ3PvA==:17 a=0Bzu9jTXAAAA:8
 a=GCZBuicCAAAA:8 a=mrHjP8x4AAAA:8 a=6_JOMXYOAAAA:8 a=cyCaf7Y57g0A:10
 a=M-Fncn8uHW8A:10 a=IkcTkHD0fZMA:10 a=zOBTXjUuO1YA:10
 a=fzm92UZ8Rl_E7fVlYCQA:9 a=QEXdDO2ut3YA:10
X-AUTH: norricorp@:2501
Received: from 5-148-128-42.cust-5.exponential-e.net ([5.148.128.42])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Thu, 09 Jul 2015 19:06:22 +0100
X-Sender: john@norricorp.f9.co.uk
User-Agent: Roundcube Webmail/0.7.4
X-Originating-IP: [5.148.128.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273767>



I am trying to compile git 2.4.5 which I downloaded as a tar file on 
AIX 6.1. The machine has gcc installed.
Having read through the INSTALL file, there appear to be several ways, 
either using configure, make, make install or just make, make install 
with prefix of where to install.
Anyway whichever approach I try I end up with the same error.
     LINK git-credential-store
ld: 0711-224 WARNING: Duplicate symbol: .bcopy
ld: 0711-224 WARNING: Duplicate symbol: .memmove
ld: 0711-345 Use the -bloadmap or -bnoquiet option to obtain more 
information.
ld: 0711-317 ERROR: Undefined symbol: .trace_argv_printf_fl
ld: 0711-317 ERROR: Undefined symbol: .trace_printf_key_fl
ld: 0711-317 ERROR: Undefined symbol: .trace_want
ld: 0711-317 ERROR: Undefined symbol: .trace_strbuf_fl
ld: 0711-317 ERROR: Undefined symbol: .trace_disable
ld: 0711-317 ERROR: Undefined symbol: .diff_can_quit_early
ld: 0711-317 ERROR: Undefined symbol: diff_queued_diff
ld: 0711-317 ERROR: Undefined symbol: .diff_setup
ld: 0711-317 ERROR: Undefined symbol: .diff_setup_done
ld: 0711-317 ERROR: Undefined symbol: .diffcore_std
ld: 0711-317 ERROR: Undefined symbol: .diff_free_filepair
ld: 0711-317 ERROR: Undefined symbol: .parse_long_opt
ld: 0711-317 ERROR: Undefined symbol: .diff_get_color
ld: 0711-317 ERROR: Undefined symbol: mime_boundary_leader
ld: 0711-317 ERROR: Undefined symbol: .getnanotime
ld: 0711-317 ERROR: Undefined symbol: .diff_flush
ld: 0711-317 ERROR: Undefined symbol: .diff_line_prefix
ld: 0711-317 ERROR: Undefined symbol: .diff_unique_abbrev
ld: 0711-317 ERROR: Undefined symbol: .alloc_filespec
ld: 0711-317 ERROR: Undefined symbol: .fill_filespec
ld: 0711-317 ERROR: Undefined symbol: .fill_textconv
ld: 0711-317 ERROR: Undefined symbol: .free_filespec
ld: 0711-317 ERROR: Undefined symbol: .diff_unmodified_pair
ld: 0711-317 ERROR: Undefined symbol: .diff_warn_rename_limit
ld: 0711-317 ERROR: Undefined symbol: .parse_algorithm_value
ld: 0711-317 ERROR: Undefined symbol: .parse_rename_score
ld: 0711-317 ERROR: Undefined symbol: .diff_change
ld: 0711-317 ERROR: Undefined symbol: .diff_unmerge
ld: 0711-317 ERROR: Undefined symbol: .diff_addremove
ld: 0711-317 ERROR: Undefined symbol: .diff_set_mnemonic_prefix
ld: 0711-317 ERROR: Undefined symbol: .diffcore_fix_diff_index
ld: 0711-317 ERROR: Undefined symbol: .diff_queue_is_empty
ld: 0711-317 ERROR: Undefined symbol: .diff_populate_filespec
ld: 0711-317 ERROR: Undefined symbol: .diff_q
ld: 0711-317 ERROR: Undefined symbol: .diff_opt_parse
ld: 0711-317 ERROR: Undefined symbol: .diff_flush_patch_id
collect2: error: ld returned 8 exit status
Makefile:1958: recipe for target 'git-credential-store' failed
gmake: *** [git-credential-store] Error 1


The machine I am building on has built git in the past (not by me).

I have downloaded the source for 2.1.0 and 1.9.2 and both of those have 
the same problem and the latter was built about 12 months ago. I had 
hoped the version of gcc was too old but I presume not. So possibly a 
problem with the environment as building as different user?

But really need help as this is very frustrating and googling has not 
found anything that quite matches it.

Regards,
John
