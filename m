From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Test 9500 - unhelpful without Perl::CGI
Date: Wed, 15 Jun 2011 11:36:23 -0700
Message-ID: <BANLkTineU1x8NDk7Q5eUN3rkg0=yPH2k=w@mail.gmail.com>
References: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com>
 <7vmxhjk539.fsf@alter.siamese.dyndns.org> <BANLkTinAfqysABm+t_NkOGO2U+iy57WbVQ@mail.gmail.com>
 <7vips7jaws.fsf@alter.siamese.dyndns.org> <7vei2vja8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:37:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWuxR-0001aV-AL
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 20:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab1FOSgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 14:36:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53976 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752383Ab1FOSgr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 14:36:47 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p5FIainA018241
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 15 Jun 2011 11:36:46 -0700
Received: by wwa36 with SMTP id 36so762322wwa.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 11:36:43 -0700 (PDT)
Received: by 10.216.145.206 with SMTP id p56mr2454289wej.80.1308163003061;
 Wed, 15 Jun 2011 11:36:43 -0700 (PDT)
Received: by 10.216.164.195 with HTTP; Wed, 15 Jun 2011 11:36:23 -0700 (PDT)
In-Reply-To: <7vei2vja8q.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-103.054 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175845>

On Wed, Jun 15, 2011 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Subject: [PATCH] t/gitweb-lib.sh: skip gitweb tests when perl dependencies are not met

Looks good. This makes t9500 go from

   not ok - 1 no commits: projects_list (implicit)
   #	gitweb_run
   not ok - 2 no commits: projects_index
   #	gitweb_run "a=project_index"
   not ok - 3 no commits: .git summary (implicit)
   #	gitweb_run "p=.git"
   not ok - 4 no commits: .git commit (implicit HEAD)
   ...
   not ok - 98 categories: projects list, only default category
   #	echo "\$projects_list_group_categories = 1;" >>gitweb_config.perl &&
   #		 gitweb_run
   # failed 91 among 98 test(s)
   1..98

to

  # passed all 0 test(s)
  1..0 # SKIP skipping gitweb tests, CGI module unusable

without perl-CGI installed. And with perl-CGI installed I obviously get

   ...
   ok 97 - ctags: malformed tag weights
   ok 98 - categories: projects list, only default category
   # passed all 98 test(s)
   1..98

So Ack on that patch.

   Thanks,
                           Linus
