X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 11:23:32 +0100
Message-ID: <200612051123.33210.jnareb@gmail.com>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz> <el2cpj$cna$1@sea.gmane.org> <Pine.LNX.4.63.0612050836570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:21:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lMPYMmCXb4HNf2vFZKoHQaRuHRe5jnHZuB93Njm/53G3xaDPScFEFvdFk6cnnJPoOrPBkwWwtVMfguDrumTyE+0+v7ZC3WW+seSImRkT6D2AGHndW8wG9lcRbwWUyXQ8O+tLKdiYyfVGaJOKhXbGopTfJsnNGJtVUFOyst91RrQ=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612050836570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33331>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrXQe-0007dk-Oo for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967947AbWLEKVd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967952AbWLEKVd
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:21:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:35606 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967947AbWLEKVc (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 05:21:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3282681uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 02:21:29 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr13441614ugj.1165314089381; Tue, 05
 Dec 2006 02:21:29 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 30sm31466457ugf.2006.12.05.02.21.28; Tue, 05 Dec
 2006 02:21:29 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> 
> On Tue 5 Dec 2006 Jakub Narebski wrote:
> 
>> Sam Vilain wrote:
>> 
>>> For those who like to spawn interactive merge tools on a merge failure
>>> or otherwise run some kind of script allow a "merge.tool" repo-config
>>> option that will take arguments as merge(1) does.
>> 
>> How it goes together with merge-recursive rewrite using built-in merge tool
>> from xdiff xdl_merge?
> 
> Not a big problem. If people like Sam's patch it is easy to integrate 
> since it only means that if merge.tool is set to something non-empty 
> xdl_merge is not called but the merge.tool is forked.

Good idea. By the way, is it replacement for RCS merge, i.e. is it
file-level merge tool, merge.onefile rather than merge.tool? What happens
if there are multiple merge [contents] conflicts: is merge.tool invoked
in parallel for each conflict, or is it waiting for earlier merge.tool
to finish (well, in which case we can always do set merge.tool to 
"<program> &")? And is merge.tool invoked for recursive part of recursive
merge strategy? This merge startegy depended on resolving conflict
markers, i.e. had built-in knowledge of 'merge'/'diff3 -E' output.

Besides, it would be useful not only to spawn interactive merge tools,
but also to use mergers specific for file-type, for example 3DM or xmlcmp
tools for merging XML files.

-- 
Jakub Narebski
