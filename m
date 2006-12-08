X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Fri, 8 Dec 2006 19:34:44 +0100
Message-ID: <e5bfff550612081034q5e4c0c93s3512fce2f11b1fab@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
	 <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
	 <20061206194258.GD20320@spearce.org>
	 <20061206195142.GE20320@spearce.org> <45781639.1050208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 18:34:53 +0000 (UTC)
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IRFxaawC68lbc6qqGBvVTJ9VlvxwkH61cMfxq1DGYHWsa5R+p19GuFSrDMyU5zrNE80LjjwPsevxw5f13ybjfLIih7g7kVbzZLURHgC6gyPzmst7zhcAQrEVFRc7utALCLAIshBs3JVz9FWW/F2LAdgziZ2rWXefzGe94QunxQ8=
In-Reply-To: <45781639.1050208@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33719>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GskYb-0001oA-LG for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760828AbWLHSeq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760827AbWLHSeq
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:34:46 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:22223 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760828AbWLHSep (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 13:34:45 -0500
Received: by py-out-1112.google.com with SMTP id a29so472122pyi for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 10:34:45 -0800 (PST)
Received: by 10.35.79.3 with SMTP id g3mr6384193pyl.1165602885044; Fri, 08
 Dec 2006 10:34:45 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Fri, 8 Dec 2006 10:34:44 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 12/7/06, Andreas Ericsson <ae@op5.se> wrote:
> Shawn Pearce wrote:
> >
> > Perhaps there is some fast IPC API supported by Qt that you could
> > use to run the revision listing outside of the main UI process,
> > to eliminate the bottlenecks you are seeing and remove the problems
> > noted above?  One that doesn't involve reading from a pipe I mean...
> >
>
> Why not just fork() + exec() and read from the filedescriptor? You can
> up the output buffer of the forked program to something suitable, which
> means the OS will cache it for you until you copy it to a buffer in qgit
> (i.e., read from the descriptor).
>

Please, what do you mean with "something suitable"? How can I redirect
the output to a memory buffer or to a file that the OS will cache
*until* I've copied it?

If I redirect to a 'normal' file, this will be flushed by OS after
some time, normally few seconds.

Could you please post links with examples/docs about this kind of
implementation?


Thanks
