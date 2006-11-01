X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 20:29:27 +0000
Message-ID: <200611012029.41869.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611010953.57360.andyparkins@gmail.com> <7vpsc710oy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 20:33:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DRTTk2zvJLKizDcW9JR86hUKb7tSIYRv58ROYoSp1Tp3weBBazdOU1XngD6BlaG/iPLz9azM8GRwyNPfgLzdCTc3jHjUPm60e3DLIjbN4LPiRAd178hRjI7bUXVqfuFzLYRe2JFzJZdkw6Sj/gZbtFIvieXuvf2kAgYw45p9lq4=
User-Agent: KMail/1.9.5
In-Reply-To: <7vpsc710oy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30654>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfMm3-0003kp-7j for gcvg-git@gmane.org; Wed, 01 Nov
 2006 21:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992807AbWKAUcO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992817AbWKAUcN
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 15:32:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:23447 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S2992812AbWKAUcM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 15:32:12 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1817493ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 12:32:10 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr8815154ugm; Wed, 01 Nov 2006
 12:32:10 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id s7sm1141863uge.2006.11.01.12.32.08; Wed, 01 Nov
 2006 12:32:09 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 01 18:28, Junio C Hamano wrote:

> So from that point of view, the above commandline perfectly
> makes sense.  However, giving anything but HEAD with path makes
> us go "Huh?"  It is unclear what this should mean:
>
> 	git-reset [--hard | --mixed] HEAD^ oops/file1

I don't understand.  Why wouldn't that mean reset oops/file1 to the state it 
had in HEAD^?

> Checkout is a working tree manipulator Porcelain, and as a side
> effect it has always updated the index.  So it might make sense
> to give --index-only there:
>
> 	git checkout --index-only HEAD -- paths...

I think you're right that this is not the place - git-checkout is what one 
uses to update your working directory, it's only a side-effect that the index 
is updated - or we could argue that it is necessary that the index is updated 
in order that checkout can do it's job.

> On the other hand, we already have --again, so maybe we have
> already passed the point of no return.  So I am inclined to
> agree with your "update-index --reset" approach, unless somebody
> else injects sanity into me.

Actually; you've talked me out of it.   Given that git-reset is already 
porcelain, and none of the solutions are screaming "right"; it seems better 
to slightly bend git-reset than git-update-index.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
