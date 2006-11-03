X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove extra "/" in path names for git_get_project_list
Date: Fri, 03 Nov 2006 12:18:00 +0100
Organization: At home
Message-ID: <eif8gd$6u5$1@sea.gmane.org>
References: <454ACF91.50601@gmail.com> <7vslh1jcji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 11:18:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30827>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfx3p-0005CS-5R for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753226AbWKCLSG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbWKCLSG
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:18:06 -0500
Received: from main.gmane.org ([80.91.229.2]:62675 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753226AbWKCLSD (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:18:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gfx3Q-00056w-Pj for git@vger.kernel.org; Fri, 03 Nov 2006 12:17:47 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 12:17:44 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006
 12:17:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
> 
>> Without this change we get a wrong $pfxlen value and the check_export_ok()
>> checks with with a wrong directory name. Without this patch the below
>> $projects_list fails with gitweb
>>
>> $projects_list = "/tmp/a/b/";
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> 
> Hmph.  Doesn't this break $projects_list = "/", I wonder?
> 
>> +            # remove the trailing "/"
>> +            $dir =~ s!/+$!!;

So perhaps

        $dir =~ s!(?<=[^/])/+$!!;

(zero-width positive look-behind assertion).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

