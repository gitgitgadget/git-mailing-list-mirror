X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 11:46:05 +0200
Message-ID: <200610251146.06116.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 25 Oct 2006 09:46:04 +0000 (UTC)
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VWR1ZMnYO/gmSDEmsLb/j7v81CobSQ1Q7T1cyiHM7yH094yVQ5sltwOjdc1aYmVsB7mB73AjFCdAS2EsOZsMj9DCZiE4ldZALu3Q3ekbHoFXkLldYRR2Avv8CLM7vtVNAT6rmdSheDwaSKFeAIUBMtZOwl8dGd5uXhlc+mDY+no=
User-Agent: KMail/1.9.3
In-Reply-To: <453F2FF8.2080903@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30042>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcfKY-0000vD-U9 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423161AbWJYJpp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWJYJpp
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:45:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:52215 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1423161AbWJYJpo
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006
 05:45:44 -0400
Received: by nf-out-0910.google.com with SMTP id c2so541902nfe for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 02:45:43 -0700 (PDT)
Received: by 10.49.92.18 with SMTP id u18mr2956663nfl; Wed, 25 Oct 2006
 02:45:42 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id p72sm475491nfc.2006.10.25.02.45.41; Wed, 25 Oct
 2006 02:45:42 -0700 (PDT)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:
> Matthew D. Fuller wrote:
>> On Fri, Oct 20, 2006 at 02:48:52PM -0700 I heard the voice of
>> Carl Worth, and lo! it spake thus:
>> 
>>> (since pull seems the only way to synch up without infinite new
>>> merge commits being added back and forth).
>> 
>> The infinite-merge-commits case doesn't happen in bzr-land because we
>> generally don't merge other branches except when the branch owner says
>> "Hey, I've got something for you to merge".  If you were to setup a
>> script to merge two branches back and forth until they were 'equal',
>> yes, it'd churn away until you filled up your disk with the N bytes of
>> metadata every new revision uses up.
> 
> This is new to me. At work, we merge our toy repositories back and forth 
> between devs only. There is no central repo at all. Does this mean that 
> each merge would add one extra commit per time the one I'm merging with 
> has merged with me?

From what I understand, "bzr merge" will create one extra commit to
preserve the "first parent is my branch" feature. "bzr pull" will do
fast-forward if your DAG is proper subset of pulled branch/repository
DAG, but at the cost that it would change your revno to revision mapping
to those of the pulled repository.

That's a consequence of preserving branch as "my work" i.e. as path
through "branch DAG" in the DAG using first parent as special, instead
of saving it outside DAG.

-- 
Jakub Narebski
