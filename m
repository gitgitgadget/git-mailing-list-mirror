X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Shouldn't git-ls-files --others use $GIT_DIR?
Date: Sun, 19 Nov 2006 19:37:56 +0100
Message-ID: <20061119183756.GZ7201@pasky.or.cz>
References: <dbfc82860611190537q77c8a358m184377a21d5a3e11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 18:38:43 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <dbfc82860611190537q77c8a358m184377a21d5a3e11@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31850>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlrYI-0002yJ-HF for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932798AbWKSSh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbWKSSh7
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:37:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19948 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932798AbWKSSh6 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:37:58 -0500
Received: (qmail 14432 invoked by uid 2001); 19 Nov 2006 19:37:57 +0100
To: Nikolai Weibull <now@bitwi.se>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 02:37:42PM CET, Nikolai Weibull wrote:
> If I do
> 
> GIT_DIR=$HOME/projects/<project>/.git git ls-files --others
> 
> from, e.g., $HOME, I get a list of all the files in $HOME and its
> subdirectories that aren't in said git repository.  Shouldn't --others
> use $GIT_DIR, instead of ".", or am I missing something here?

git-ls-files --others lists untracked files in the current directory by
comparing it to the index stored in $GIT_DIR/index and listing files
present in the current directory but not in the index.

GIT_DIR is a path to the Git repository the commands should work with,
but if they work on working tree, they look at the current directory for
it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
