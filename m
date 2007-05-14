From: Noel Grandin <noel@peralex.com>
Subject: Re: [PATCH] Require JDK1.5
Date: Mon, 14 May 2007 09:21:38 +0200
Message-ID: <46480E02.1010500@peralex.com>
References: <11790995571082-git-send-email-robin.rosenberg@dewire.com> <1179100134893-git-send-email-robin.rosenberg@dewire.com> <11791001343234-git-send-email-robin.rosenberg@dewire.com> <Pine.LNX.4.63.0705140303380.17507@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Grzegorz Kulewski <kangur@polcom.net>
X-From: git-owner@vger.kernel.org Mon May 14 09:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnVB7-0003xH-LD
	for gcvg-git@gmane.org; Mon, 14 May 2007 09:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXENHlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 03:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbXENHlG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 03:41:06 -0400
Received: from mail.peralex.com ([196.1.58.220]:49505 "EHLO mail.peralex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbXENHlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 03:41:04 -0400
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 May 2007 03:41:03 EDT
Received: from [192.168.1.165] (noel.ct [192.168.1.165])
	by mail.peralex.com (8.14.1/8.14.1) with ESMTP id l4E7LcA6006573;
	Mon, 14 May 2007 09:21:38 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <Pine.LNX.4.63.0705140303380.17507@alpha.polcom.net>
X-Enigmail-Version: 0.94.0.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.61 on 192.168.1.7
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup2@peralex.com, mailbackup2@peralex.com
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (mail.peralex.com [192.168.1.7]); Mon, 14 May 2007 09:21:39 +0200 (SAST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47224>


>> diff --git
>> a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
>> b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
>> index c397a0d..63796fd 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
>> @@ -50,9 +50,9 @@ public class ObjectIdMap implements Map {
>>
>>     public ObjectIdMap(Map sample) {
>>         try {
>> -            Method m=sample.getClass().getMethod("clone", null);
>> +            Method m=sample.getClass().getMethod("clone",
>> (Class[])null);
>>             for (int i=0; i<256; ++i) {
>> -                level0[i] = (Map)m.invoke(sample, null);
>> +                level0[i] = (Map)m.invoke(sample, (Object[])null);
>>             }
>>         } catch (IllegalAccessException e) {
>>             throw new IllegalArgumentException(e);
>
> I wonder why one would need changes like this?
>
> These casts are not needed for anything as far as I can see and your
> IDE should easily tell you what type that parameter is. No?
>
Those are varargs parameters, so when compiling under 1.5 you sometimes
have to tell the compiler the difference between passing a varargs array
and passing one parameter.


Disclaimer: http://www.peralex.com/disclaimer.html
