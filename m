X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git_get_projects_list and $projects_list
Date: Tue, 31 Oct 2006 13:23:32 +0100
Organization: At home
Message-ID: <ei7f7o$bgi$1@sea.gmane.org>
References: <cc723f590610310347h58cdd69bse6d96b19479a4f6a@mail.gmail.com> <ei7dq4$828$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 31 Oct 2006 12:24:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30581>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geser-0006zy-54 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 13:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422840AbWJaMXu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 07:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161649AbWJaMXu
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 07:23:50 -0500
Received: from main.gmane.org ([80.91.229.2]:18105 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161648AbWJaMXt (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 07:23:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GeseV-0006w4-9O for git@vger.kernel.org; Tue, 31 Oct 2006 13:23:35 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 13:23:35 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 31 Oct 2006
 13:23:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

> Aneesh Kumar wrote:
> 
>> Ok if i have
>> 
>> $projects_list = "/a/git////" ==> ending "/" . the function will fail
>> at check_export_ok()
>> 
>> That is because we get the $pfxlen wrong. We should ignore all the trailing "/"
>> my $subdir = substr($File::Find::name, $pfxlen + 1);
> 
> Perhaps it would be enough to just add 
>         $dir =~ s!/+$//; 

Ooops, it should of course be

        $dir =~ s!/+$!!;

> before  
>         my $pfxlen = length("$dir");
> (or something equivalent). Try it and send us a patch.


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

