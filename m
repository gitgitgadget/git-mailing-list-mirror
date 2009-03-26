From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: [PATCH JGIT 1/2] Calculate CRC32 on Pack Index v2
Date: Thu, 26 Mar 2009 08:49:18 +0800
Message-ID: <ff6a9c820903251749q41977ee0wf776a43dc8e420fb@mail.gmail.com>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
	 <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
	 <49CA3218.9090202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 01:50:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmdo4-00014O-SQ
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 01:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZCZAtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 20:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbZCZAtV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 20:49:21 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:8253 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZCZAtU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 20:49:20 -0400
Received: by an-out-0708.google.com with SMTP id d14so262333and.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TspN0go5YLNGsqBhyWb2bMWumQUKGfMRxGIPTiWcb/0=;
        b=KhEXp0PQgQxbW+wa9i1gq50HpxHg4Ch3pwFD9v8zBDP6KbhwwcQAPo56H2TxO9i7pM
         8oLLP1KjD4OROycKsw4CfjUdzBxxqqbRgJvvJqwX7ro3K2IvCBu794B9jDsrzeNKEjhQ
         0Y5G7PYXmAZKttzB+a+nE3v7oJ2psx8ggegrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UEJTJaOo8Dj0Z7L3STmXaXspUY8tHXXtUYaLoTY7k0oEhCdI1z0bvh+3PMSNnYgcVw
         rVqXzNpe/XUIwGQyKoxVaiq2PfHNrX30/BJ1KEPzmQysrt4yA+Z6Xa1KYo0tPvOWIZXY
         /Lnn7U7KRlz+WoHO4jY9GRgdmleScuerZsNM0=
Received: by 10.231.20.1 with SMTP id d1mr59530ibb.17.1238028558324; Wed, 25 
	Mar 2009 17:49:18 -0700 (PDT)
In-Reply-To: <49CA3218.9090202@gmail.com>
X-Google-Sender-Auth: 1160947a5afa0a47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114697>

On Wed, Mar 25, 2009 at 9:31 PM, Marek Zawirski
<marek.zawirski@gmail.com> wrote:
> Hi,
>
> Thanks for spotting this bug.
> (...)
[...]
>
> Have you tested that code? It seems that CRC32 updates is =A0missing =
in
> write() method... or did I slept too short this night?:)

Sure I have tested some code, the wrong one.

The buggy code is at PackWriter.writeIndex(), and
the test case I have tested is using IndexPack.index().

=2E. hm...

I am thinking if we can combine two of them.

> Best,
> Marek
>
