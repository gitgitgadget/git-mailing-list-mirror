From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/fast-import: put explanation of M 040000
 <dataref> "" in context
Date: Tue, 18 Jan 2011 15:16:54 -0600
Message-ID: <20110118211654.GA22763@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20110116022234.GA28452@burratino>
 <7v1v4amex6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfIvT-0002VW-OR
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1ARVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:17:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62172 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1ARVRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:17:09 -0500
Received: by fxm20 with SMTP id 20so98603fxm.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v+lmxjVeAJAhbmNrBx1wLO++OsptC861g+OR04L9us8=;
        b=RS4SnLWQ5wPr3ImIbXaFomBqDDTOOFpYW1ahg0gfPIeANbdFeEeOy3BUBlYo3lXdpW
         7VD3XeiI6m0/o3DMleVL2UIcDe0BHM2KaATTLmK55Fhu/q4yDnvoLBJT0qe9XXenMLFc
         fT0G2zCJCHaxbToM4jod6t4UYLJklr6iqO8dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dcFjYmmliy3omVnydjJJZ6uHfxpLnzDrW2lqYrhAfMqV/Gc8dBqruOTEecED8n7uyZ
         A+wqu3Bu2FOhmkmEcDvq1ZZ0ghsKX0w0IpsDrXN/JNIKIdOPLzO6kIolvA2PdB+U00ye
         ZKc73HBgpOTc3K3doTFuyT9eL26/o8FFNkcTE=
Received: by 10.223.113.73 with SMTP id z9mr6826685fap.41.1295385428527;
        Tue, 18 Jan 2011 13:17:08 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 5sm2316761fak.23.2011.01.18.13.17.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 13:17:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v4amex6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165219>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/Documentation/git-fast-import.txt
>> @@ -545,6 +542,9 @@ The value of `<path>` must be in canonical form. That is it must not:
>>  * contain the special component `.` or `..` (e.g. `foo/./bar` and
>>    `foo/../bar` are invalid).
>>  
>> +In `040000` mode, `<path>` can be the empty string (`""`)
>> +to specify the root of the tree.
>> +
>
> Thanks, but is "In x mode" an appropriate wording here in the first place?

Good point.  No, it isn't.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
For squashing.

 Documentation/git-fast-import.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 43d2174..7068de3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -542,7 +542,7 @@ The value of `<path>` must be in canonical form. That is it must not:
 * contain the special component `.` or `..` (e.g. `foo/./bar` and
   `foo/../bar` are invalid).
 
-In `040000` mode, `<path>` can be the empty string (`""`)
+If `<mode>` is `040000`, `<path>` can be the empty string (`""`)
 to specify the root of the tree.
 
 It is recommended that `<path>` always be encoded using UTF-8.
-- 
1.7.4.rc2
