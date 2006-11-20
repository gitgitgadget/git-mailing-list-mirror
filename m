X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 10:50:55 +0100
Message-ID: <200611200951.05529.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 09:51:29 +0000 (UTC)
Cc: Alexander Litvinov <litvinov2004@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WIPflXLKPBHT+bfeFwWv3dwRPs9yUZPNkigdApeY8BL4/Tn/6glizpPBe8/vk6K0O8drA7btoU32XIsqrRn8quvuPP84OIJA0Uhg9d6LfQPot9Rau5lE+vjiP0S3pWDguYvvfQw54tefUMbgMOlNmAaJmC67Z3ngj+P/qYFRfvk=
User-Agent: KMail/1.9.5
In-Reply-To: <200611201157.23680.litvinov2004@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31891>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm5o3-0001ty-Vv for gcvg-git@gmane.org; Mon, 20 Nov
 2006 10:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965253AbWKTJvN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 04:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWKTJvN
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 04:51:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8347 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965253AbWKTJvL
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 04:51:11 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1128415ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 01:51:10 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr5926331ugm.1164016269958; Mon, 20
 Nov 2006 01:51:09 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k30sm8122206ugc.2006.11.20.01.51.09; Mon, 20 Nov 2006 01:51:09 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 05:57, Alexander Litvinov wrote:

> > PAGER=cat git log -M -C --pretty=oneline b/a

I've come across this too.  Personally I'm not sure what use "-C" is.  From 
the manpage, man git-diff-files (no, this isn't the place I'd look either).

--find-copies-harder
For performance reasons, by default, -C option finds copies only if the 
original file of the copy was modified in the same changeset. This flag makes 
the command inspect unmodified files as candidates for the source of copy. 
This is a very expensive operation for large projects, so use it with 
caution.

That is to say that unless the file you are copying was modified AND copied in 
the same commit, it won't be searched as a potential source for the copy 
operation.  I think it would be rare to make a copy of a file I had modified, 
surely I'd want to check in modifications before making a copy?

Regardlss, to get the results you want, use the stronger 
switch --find-copies-harder, heeding the warning that on big projects it will 
be very slow.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
