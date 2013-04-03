From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 3 Apr 2013 17:11:27 +0200
Message-ID: <877gkjvecg.fsf@linux-k42r.v.cablecom.net>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
	<7vzjxf64gn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPLz-0002MJ-4v
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762166Ab3DCPLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:11:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26759 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761720Ab3DCPL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:11:29 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 3 Apr
 2013 17:11:21 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 3 Apr 2013 17:11:27 +0200
In-Reply-To: <7vzjxf64gn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 03 Apr 2013 08:04:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219945>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> +<commit>, <object>::
>> +	The object that the new tag will refer to, usually a commit.
>> +	Defaults to HEAD.
>
> Shouldn't this be more like this:
>
>     <commit>::
>     <object>::
> 	Your explanation here...

Hmm, you're right, but we seem to be fairly inconsistent in that
department.  There are some instances with the comma style:

  $ git grep ',.*::$' Documentation/*.txt
  Documentation/blame-options.txt:-L <start>,<end>, -L :<regex>::                                        
  Documentation/config.txt:gitcvs.dbuser, gitcvs.dbpass::                                                
  Documentation/config.txt:http.lowSpeedLimit, http.lowSpeedTime::                                       
  Documentation/diff-options.txt:--stat[=<width>[,<name-width>[,<count>]]]::                             
  Documentation/diff-options.txt:--dirstat[=<param1,param2,...>]::                                       
  Documentation/git-add.txt:-e, \--edit::                                                                
  Documentation/git-check-attr.txt:-a, --all::                                                           
  Documentation/git-check-ignore.txt:-q, --quiet::                                                       
  Documentation/git-check-ignore.txt:-v, --verbose::                                                     
  Documentation/git-index-pack.txt:--index-version=<version>[,<offset>]::                                
  Documentation/git-log.txt:-L <start>,<end>:<file>, -L :<regex>:<file>::                                
  Documentation/git-log.txt:git log -L '/int main/',/^}/:main.c::                                        
  Documentation/git-p4.txt:--verbose, -v::                                                               
  Documentation/git-p4.txt:--dry-run, -n::                                                               
  Documentation/git-p4.txt:"//depot/my/project@1,6"::                                                    
  Documentation/git-pack-objects.txt:--index-version=<version>[,<offset>]::                              
  Documentation/git-remote-fd.txt:`git push fd::7,8 master (as URL)`::                                   
  Documentation/git-remote-fd.txt:`git push fd::7,8/bar master`::
  Documentation/git-reset.txt:Undo a commit, making it a topic branch::
  Documentation/git-shortlog.txt:-w[<width>[,<indent1>[,<indent2>]]]::
  Documentation/git-show-branch.txt:--reflog[=<n>[,<base>]] [<ref>]::
  Documentation/git-tag.txt:<commit>, <object>::
  Documentation/revisions.txt:'<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
  Documentation/revisions.txt:'<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
  Documentation/revisions.txt:'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
  Documentation/revisions.txt:'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\
  Documentation/revisions.txt:'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
  Documentation/revisions.txt:'@\{<n>\}', e.g. '@\{1\}'::
  Documentation/revisions.txt:'@\{-<n>\}', e.g. '@\{-1\}'::
  Documentation/revisions.txt:'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
  Documentation/revisions.txt:'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
  Documentation/revisions.txt:'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
  Documentation/revisions.txt:'<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
  Documentation/revisions.txt:'<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
  Documentation/revisions.txt:'<rev>{caret}\{/<text>\}', e.g. 'HEAD^{/fix nasty bug}'::
  Documentation/revisions.txt:':/<text>', e.g. ':/fix nasty bug'::
  Documentation/revisions.txt:'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
  Documentation/revisions.txt:':<n>:<path>', e.g. ':0:README', ':README'::
  Documentation/revisions.txt:'<rev>{caret}@', e.g. 'HEAD{caret}@'::
  Documentation/revisions.txt:'<rev>{caret}!', e.g. 'HEAD{caret}!'::

But the majority uses the two-line style:

  $ git grep -A1 '::$' Documentation/*.txt | egrep '^--$|::$' | perl -ne '$lastbreak=$. if /^--/; if ($lastbreak<$.-1) {print "$last$_"; $last="";} else {$last=$_;}'
  Documentation/blame-options.txt:-p::
  Documentation/blame-options.txt:--porcelain::
  Documentation/config.txt:add.ignore-errors::
  Documentation/config.txt:add.ignoreErrors::
  Documentation/config.txt:format.to::
  Documentation/config.txt:format.cc::
  Documentation/config.txt:gc.reflogexpire::
  Documentation/config.txt:gc.<pattern>.reflogexpire::
  Documentation/config.txt:gc.reflogexpireunreachable::
  Documentation/config.txt:gc.<ref>.reflogexpireunreachable::
  Documentation/config.txt:gitweb.category::
  Documentation/config.txt:gitweb.description::
  [snip 800+ more lines]

Should we fix that?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
