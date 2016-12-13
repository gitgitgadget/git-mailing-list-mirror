Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4AD203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbcLMTbI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:31:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:54369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933813AbcLMTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:30:21 -0500
Received: from [192.168.178.43] ([88.71.224.113]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDE6y-1cOcx23OnM-00GXmd; Tue, 13
 Dec 2016 20:22:00 +0100
Subject: git add -p with unmerged files (was: git add -p with new file)
To:     Ariel <asgit@dsgml.com>, git@vger.kernel.org
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Message-ID: <98817141-fa57-7687-09c4-dc96419d8a35@gmx.net>
Date:   Tue, 13 Dec 2016 20:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bmxsj2mI+v5wpgtQppEiYrZGCYrC2huNuwJ/3YKZ+60YIwcHqny
 Kotd6trKw93VxxpgewbtfyB6cHJeQoEp+QhbGuRKgQ8fuTiv+m0kcXBf1nqUskWgbfbtiLl
 sSRTiFsDcj601dbQoxUtBKveFgpmee8lGU1rudaypP4dvu/2GacC6IZ0AqXNjXw4nTr9wbX
 VT5ug0om+AYBNCXW+SU8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JCPa9ApZAog=:h7SfS4DOHgno6pnbqjxt4j
 cgPlvFeg+chFTIHplFna+piZMp6mFXIBJi1BqZ6v517T3ekTfKt1j8ZvoB5E6UkTvkN60Vd12
 9zNCHc7BadiybjrjXF/96PY5Bqf9SxQKwu23fDWa7wteaIjT5wommj4CQJAwUYw3qI4jR3Htw
 PlRqEN50bytPStFw3JGnOXMNq5XB7CaMCXU6jWdwAE31/ror6jAERdfU2QKkSKPFMGkeEjw0v
 OGaQ5n4M5qDYf05TNOhp7+0eZH9N0XczBz+UG0rkLN5OZ1+3sjXMtEbhzO4Wc+6rkw3mez6ly
 gB0raQhmCKiXBVIagDwxgKKHsWYRV+kxI3tX4ICycbImXzM2kIE4st2XGLG2Mcqrs1rkcgyVQ
 ThHrQnICUNUQqD98CodQLD9xzTzTGorq1458mCjTwbnfSdmu5LXEdURp6ClPKBzh0MVnhllCc
 05unkEZECJ9IAuIJPrFPkqWBHqeq57rakgQ9JcuwRjW75xM88AVwjNnWJHAYCryg+moSmk1cp
 CT12fFnafIzffG1tayUUfTpRb7r2WfQt2YgS9YLz8BQ6JeDOiPEMUH5brpPnBrM+pp+VMbTak
 RyhsQ9pj5lfRUwZTojDb1oGtfyCP8kiMswPqP99T9z4zshZGYRotOjJG7B1kOMgGeq9sPqCEz
 GmJ6UAzQxBUqGCc4qAb89e+p0lFfdWbfc8An/usqGNAkEIQ2qLGVy5s8uHBD4ULL7zoEP4BeZ
 nwyxe5pdG8uMqi+TWBwEzxdtm99gI4jchW7fUbl0kTH9zo7h1fNa8cblpB01g+wpnYWkE0jmw
 KiKdYeu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While we're on the topic that "git add -p" should behave like the
"normal" "git add" (not "git add -u"): what about unmerged changes?

When I have merge conflicts, I almost always use my aliases
"edit-unmerged" and "add-unmerged":

$ git config --global --list | grep unmerged
alias.list-unmerged=diff --name-only --diff-filter=U
alias.edit-unmerged=!vim `git list-unmerged`
alias.add-unmerged=!git add `git list-unmerged`
alias.reset-unmerged=!uf=`git list-unmerged`; git reset HEAD $uf; git
checkout -- $uf

The "add-unmerged" alias is always a little scary because I'd rather
like to check the changes with the "git add -p" workflow I am used to.

Opinions?

Best
  Stephan
