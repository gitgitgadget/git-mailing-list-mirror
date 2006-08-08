From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 23:13:51 +0200
Organization: At home
Message-ID: <ebauq1$kcb$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 23:15:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAYut-0002WA-2a
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 23:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWHHVOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWHHVOT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 17:14:19 -0400
Received: from main.gmane.org ([80.91.229.2]:40912 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030298AbWHHVOI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 17:14:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAYtZ-0002DW-Qt
	for git@vger.kernel.org; Tue, 08 Aug 2006 23:13:50 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 23:13:49 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 23:13:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25090>

Jakub Narebski wrote:

> Renames:
> - git_get_referencing => format_mark_referencing
> - git_read_head => git_get_head
> - read_info_ref => git_read_info_refs
> - date_str => parse_date
> - git_read_tag => parse_tag
> - git_read_commit => parse_commit
> - git_blob_plain_mimetype => blob_plain_mimetype
> - git_page_nav => git_print_page_nav
> - git_header_div => git_print_header_div

Summary of discussion: using *_read_* to distinguish between git calling
commands, and file reading commands is not a good idea. So now the
guideline is to be more fluid with *_get_* vs *_read_* subroutine naming:
it would depend on the noun after _get_ or _read_.


Proposed renames:
1. Renames I think everybody would agree on
 - git_get_referencing => format_mark_referencing

 - date_str => parse_date
 - git_read_tag => parse_tag
 - git_read_commit => parse_commit

 - git_blob_plain_mimetype => blob_plain_mimetype

 - git_page_nav => git_print_page_nav
 - git_header_div => git_print_header_div


2. Renames about which I'm less sure
 - git_read_head => git_get_head_hash
 - git_read_hash => git_get_hash_by_ref

 - git_read_description => git_project_description
 - git_read_projects => git_get_projects_list or git_list_projects

 - read_info_ref => git_read_info_refs => git_get_references
 (this one depend too much on implementation, which might be changed to 
  parsing 'git ls-remotes .' output instead of relying on info/refs being
  up to date thanks to git-update-server-info in post-update hook, 
  and on its format).

 - age_string => ????
 (it returns 'nn ago' string)


Thoughts? Comments? I'm especially interested in answer of other people
working on gitweb (Luben Tuikov, Matthias Lederhofer, Jeff King,  
Sham Chukoury, and others).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
