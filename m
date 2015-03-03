From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 3 Mar 2015 17:33:51 +0700
Message-ID: <20150303103351.GA4922@lanh>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
 <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com>
 <20150302092136.GA30278@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSk8n-0005vx-0A
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbbCCKdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:33:24 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35023 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbCCKdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 05:33:22 -0500
Received: by pdbft15 with SMTP id ft15so21575434pdb.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5xXRlrwMmGfWlNx27eqU3RqpWQ5LdVGVp5NhmU3maco=;
        b=rltk0lVmKsVTBmP6QgeX+dDYB/aHXQOaytdM4sQ6T04V37W2Z6geeglBL13RU0ZSOF
         YLDaSV3Pkvh1M5KlB+FGNdQW4rj0cCZIkwhgVRHMzjDP3Me0Npmh8StbyAlFrOIEQWYF
         gsIKvp2FshqcZhQCraPe6EJJPQpa1/I0rBwCfcCSvLj3mA0L8jiMx7WuPf1FnfXz7rL/
         xzXbiF3Ky9+uio3AK2At0u7/ol2hd/78udP6JqnFhPpTOZUU1ZcDooUNTqxtC03/Ya4c
         zDVMSpz/eboMhg42Xapk99hGdFNjR030TbS4Fa6iRQhnkvcfslCyWmnG+VFdMZTXckif
         Wk7A==
X-Received: by 10.67.8.73 with SMTP id di9mr54029872pad.107.1425378802250;
        Tue, 03 Mar 2015 02:33:22 -0800 (PST)
Received: from lanh ([115.73.224.188])
        by mx.google.com with ESMTPSA id ck2sm493199pbc.80.2015.03.03.02.33.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 02:33:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 Mar 2015 17:33:51 +0700
Content-Disposition: inline
In-Reply-To: <20150302092136.GA30278@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264646>

On Mon, Mar 02, 2015 at 04:21:36PM +0700, Duy Nguyen wrote:
> On Sun, Mar 01, 2015 at 07:47:40PM -0800, Junio C Hamano wrote:
> > It seems, however, that our current thinking is that it is OK to do
> > the "allow new v1 clients to notice the availabilty of v2 servers,
> > so that they can talk v2 the next time" thing, so my preference is
> > to throw this "client first and let server notice" into "maybe
> > doable but not our first choice" bin, at least for now.
> 
> OK let's see if first choice like this could work. Very draft but it
> should give some idea how to make a prototype to test it out. Note
> that the server still speaks first in this proposal.

Junio pointed out in private that I didn't address the packet length
limit (64k). I thought I could get away with a new capability
(i.e. not worry about it now) but I finally admit that was a bad
hack. So perhaps this on top.

The "WARN" line was originally supposed to be used when packet length
is still 64k and the server has a ref longer than that. It could then
skip that long ref and inform the user, so the user could re-request
again, this time asking for "long packet length" capability.

That's irrelevant now. But I think an option to say something without
abort may still be a good idea, especially if we allow hooks to
intercept the protocol.

-- 8< --
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 32a1186..e2003c0 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -37,6 +37,20 @@ communicates with that invoked process over the SSH connection.
 The file:// transport runs the 'upload-pack' or 'receive-pack'
 process locally and communicates with it over a pipe.
 
+Pkt-line format
+---------------
+
+In version 1, a packet line consists of four bytes containing the
+length of the entire line plus four, in hexadecimal format. A flush
+consists of four zero bytes.
+
+In version 2, the four-byte header format remains supported but the
+maximum length is 0xfffe. If the length is 0xffff, the actual length
+follows in variable encoding in hexadecimal.
+
+XXX: perhaps go with 2-byte length by default instead because we don't
+usually need pkt-line longer than 256?? Maybe not worth saving a couple bytes
+
 Git Transport
 -------------
 
@@ -68,10 +82,12 @@ process on the server side over the Git protocol is this:
      nc -v example.com 9418
 
 If the server refuses the request for some reasons, it could abort
-gracefully with an error message.
+gracefully with an error message, or show a warning but and keep
+moving.
 
 ----
   error-line     =  PKT-LINE("ERR" SP explanation-text)
+  warning-line   =  PKT-LINE("WARN" SP explanation-text)
 ----
 
 SSH Transport
-- 8< --
