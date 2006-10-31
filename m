X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git_get_projects_list and $projects_list
Date: Tue, 31 Oct 2006 17:17:58 +0530
Message-ID: <cc723f590610310347h58cdd69bse6d96b19479a4f6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 11:48:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bFfeK3oi/LXw3wlduRChZ7KgtJKu3v7FhjFnxKUE2GC7rg6N3ppCbd9VVnbSK1RAz3PuI0/si2ZiGog+yqL112mDXHWaHoRt9KVnzFUaZn3p/7iqYC+phFKPnww97atsakkwU/a7EjXKqvb9vh7FiEgbV87y61bWhSArA8uIdHk=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30579>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ges69-0008Ud-Kp for gcvg-git@gmane.org; Tue, 31 Oct
 2006 12:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161636AbWJaLsA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161638AbWJaLsA
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 06:48:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:18559 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1161636AbWJaLr7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 06:47:59 -0500
Received: by nf-out-0910.google.com with SMTP id c2so316684nfe for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 03:47:58 -0800 (PST)
Received: by 10.49.55.13 with SMTP id h13mr148259nfk.1162295278223; Tue, 31
 Oct 2006 03:47:58 -0800 (PST)
Received: by 10.48.212.18 with HTTP; Tue, 31 Oct 2006 03:47:58 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Ok if i have

$projects_list = "/a/git////" ==> ending "/" . the function will fail
at check_export_ok()


That is because we get the $pfxlen wrong. We should ignore all the trailing "/"
my $subdir = substr($File::Find::name, $pfxlen + 1);


