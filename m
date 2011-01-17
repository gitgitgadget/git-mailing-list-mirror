From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 14:55:42 -0600
Message-ID: <20110117205542.GA21507@burratino>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
 <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
 <20110117115133.GA29207@burratino>
 <20110117133843.GA23625@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	"Aaron S. Meurer" <asmeurer@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 17 21:56:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pew7Q-0003NM-FK
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 21:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab1AQUz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 15:55:56 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46655 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab1AQUz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jan 2011 15:55:56 -0500
Received: by vws16 with SMTP id 16so2175698vws.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o7kqmnQxM5v9jjus/cpZCtihWXnwnLEz/5hQxDczsT4=;
        b=RN0rfZUS02k6qPF2zxUwp8bXg9vRMzSLnI8cBsK5h516UFvQak1mBlFBuDqCFkhgT8
         oAkHCXEF8WjiGTlXGfzQPoZ1G2+0XALB8ocjz8ijcwSN7i8w/t7Eq4z3BdD3RieMmFkO
         Aku215oZ1HEGniwftL6c1SUz3K3YmEzQU85ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XU8cDbzLuXoFTHuqe0qBVhXfqFUR/mkOgaFHG/2J0/mu78TmBfHQtOlPLlFFFL0SHt
         G/MTpnyIObz3LVrciwkFtNZwHZXNPiAQAWSNOaYKwGugET2Uu1D5LdmeymlzJ89U23te
         Dy8FlI4KZjWaLhh/A71tY18cvKDIQ3ONEPNH0=
Received: by 10.220.200.135 with SMTP id ew7mr1534251vcb.37.1295297753340;
        Mon, 17 Jan 2011 12:55:53 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id w26sm1350225vcf.21.2011.01.17.12.55.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 12:55:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110117133843.GA23625@neumann>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165179>

SZEDER G=C3=A1bor wrote:
> On Mon, Jan 17, 2011 at 05:51:33AM -0600, Jonathan Nieder wrote:
>> Christian Couder wrote:

>>> Yeah, many people find it difficult to reverse the meaning of "bad"
>>> and "good" when looking for a fix. There were some suggestions at s=
ome
>>> points to do something about it. Some of the suggestions were to us=
e
>>> some aliases for "good" and "bad", but there was no agreement. Othe=
r
>>> suggestions had a patch attached but the patch was not good enough =
or
>>> something.
>>
>> Any pointers to such a discussion or patch?  Maybe whatever small
>> detail caused it to be forgotten could be fixed...
>
> http://thread.gmane.org/gmane.comp.version-control.git/86063

A better link for those who are thinking of picking up the topic might
be [1].

The problems were:

 - error messages refer to "good" and "bad" with the original,
   unreversed meaning, which could be confusing (but see later in the
   thread!).
 - "git bisect visualize" doesn't get the memo about the new worldview.
 - it seems that some people lost interest after a while.

None of these seems totally fatal --- as a new feature, it would not
be breaking anyone's workflow, especially if the potentially confusing
bits are clearly documented.

Thanks.

[1] http://thread.gmane.org/gmane.comp.version-control.git/86089/focus=3D=
86161
