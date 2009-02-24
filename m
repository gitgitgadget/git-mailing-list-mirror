From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 00/23] builtin-remote improvments
Date: Tue, 24 Feb 2009 05:53:36 -0500
Message-ID: <1235472816-52420-1-git-send-email-jaysoffian@gmail.com>
References: <cover.1235461736.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 11:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbuwR-0005BV-Tv
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 11:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbZBXKxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 05:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbZBXKxm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 05:53:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:51801 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZBXKxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 05:53:41 -0500
Received: by gxk22 with SMTP id 22so6502028gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sb0QUXz4PsxyvAQ3OuUshsWe4u4jJlU3bILyADE4yg8=;
        b=Xt3xlEl37X06s/p5KS6njivS2AqRB29y+VzcU4yw2hFAat4EQKc1Pg6QGdKXMQVNig
         gdImh2R17q1RNKdL70TPCP9cKuFKjAR9B1t4wH08c2KFYr/1/SDGrRkVKA8soYsCtPg0
         DmqmHMYZLKS1s5FLNbRQOiT0mY5jeEMa9V7mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ByJIVONQVI1oMVzLFs86K3CNLUXWgSZ5Drkknn2PAWoOQuik0RuoN6oo3hqpW8xZwX
         YROufXZFM9GpkI11w2eG3Efn4Hhq224xqvWtqzD1xqDHeQwWExnS5XGC55J9LMQzs7YK
         Wbf8SNKhmnD3/ULrHtsy22jnCOOYbcqyZ0AXw=
Received: by 10.100.140.20 with SMTP id n20mr1958015and.12.1235472819273;
        Tue, 24 Feb 2009 02:53:39 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c40sm9830856anc.48.2009.02.24.02.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 02:53:38 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235461736.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111281>

On Tue, Feb 24, 2009 at 4:50 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Jay Soffian (18):
>  builtin-clone: move locate_head() to remote.c so it can be re-used
>  builtin-remote: move duplicated cleanup code its own function
>  builtin-remote: teach show to display remote HEAD
>  builtin-remote: add set-head subcommand
>  builtin-remote: better handling of multiple remote HEADs
>
>  remote.c: make match_refs() copy src ref before assigning to peer_ref
>  remote.c: don't short-circuit match_refs() when error in match_explicit_refs()
>  refactor duplicated get_local_heads() to remote.c
>  refactor duplicated ref_newer() to remote.c
>  string-list: new for_each_string_list() function
>  builtin-remote: rename variable and eliminate redundant function call
>  builtin-remote: name remote_refs consistently
>  builtin-remote: remove unused code in get_ref_states
>  builtin-remote: fix two inconsistencies in the output of "show <remote>"
>  builtin-remote: make get_remote_ref_states() always populate states.tracked
>  builtin-remote: refactor get_remote_ref_states()
>  builtin-remote: new show output style
>  builtin-remote: new show output style for push refspecs
>
> Jeff King (5):
>  test scripts: refactor start_httpd helper
>  add basic http clone/fetch tests
>  refactor find_refs_by_name to accept const list
>  remote: refactor guess_remote_head
>  remote: use exact HEAD lookup if it is available

Argh. Looking at this again, it seems clear to me now that I should've put Jeff's series at the beginning, followed by my refactoring (6-10), followed by the rest of my patches, so that all the refactoring is early.

And I forgot that I'd done patch #5 (better handling of multiple remote HEADs) a few days after 1-4. As part of this re-roll I should've redone 1-4 to include #5's functionality.

I also noticed I'm passing an argument to get_head_names() that it never uses. But fixing that touches at least 3 of the patches.

All of this is my way of saying ignore what I've emailed tonight till I can clean it up a bit more.

I apologize to the list for the spam.

When I have the series really ready, would you prefer I setup a repo for you to pull from? I'm loath to spam the list with another 24 messages.

j.
