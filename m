X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 08 Dec 2006 16:37:13 -0800
Message-ID: <m2d56taoqu.fsf@ziti.local>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<200612082310.24140.Josef.Weidendorfer@gmx.de>
	<m2lkli9bwv.fsf@ziti.local> <elcujo$g61$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 00:37:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=paXB8xCHnw0rJd3R7vcoZI9V76wFPhUHsIu7PGICCEsmDDJJz0hPqNUhEvgiFlmf/5Cdm0v3Q+217oSo9LPbSx4pXDTk3gyzJAvKFSOWjpa6joaynDB3jjUQT3HHRN0JbkFhSY3Yi3nxJfMBt3UCcg9TyGikHuk5j9tDJSQjNdY=
In-Reply-To: <elcujo$g61$1@sea.gmane.org> (Jakub Narebski's message of "Sat, 09 Dec 2006 01:07:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33778>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsqDS-00049K-Ad for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947590AbWLIAhT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947592AbWLIAhS
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:37:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:7088 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947590AbWLIAhR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 19:37:17 -0500
Received: by wx-out-0506.google.com with SMTP id h27so956317wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 16:37:16 -0800 (PST)
Received: by 10.70.116.1 with SMTP id o1mr7042018wxc.1165624636479; Fri, 08
 Dec 2006 16:37:16 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 39sm6206321wrl.2006.12.08.16.37.15; Fri, 08 Dec 2006 16:37:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Seth Falcon wrote:
>> Spelling out a bunch of files spread around your tree for update-index
>> can be annoying.  Some way of marking a list seems natural.  Maybe
>> that is a separate issue.
>
> Perhaps git-commit should also accept --exclude=<pattern> option?
> Would that help?

I don't think I understand what an --exclude=<pattern> option would
do, but I'm pretty sure it doesn't help the use case I'm thinking of:

   Editing away, you've made changes in 8 files.

   Reviewing diff, you want to commit 6 of those and continue working
   on the other two.

   It seems that there could be a less manual way than 
   git update-index f1 f2 ... f6


Hmm, maybe I could do:

   git diff --name-only > changed
   ## edit changed
   cat changed|xargs git update-index

I suppose this could be wrapped in a simple way to bring up an editor.

