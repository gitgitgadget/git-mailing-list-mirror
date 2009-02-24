From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Issues building docs on an offline box again.
Date: Tue, 24 Feb 2009 08:04:47 -0500
Message-ID: <c115fd3c0902240504y9fe6ce4m65ba73ce2937cb9e@mail.gmail.com>
References: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com>
	 <20090224022856.GN4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 14:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbwzK-0004Yx-L0
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 14:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbZBXNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbZBXNEv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 08:04:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:33308 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbZBXNEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 08:04:50 -0500
Received: by gxk22 with SMTP id 22so6593123gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6ClyBI82F2QIRlKWUW7dPn5xGaCzDCc7WD1dgZbzr2Q=;
        b=qBY+bghRlCfuFN7uvwfRJeCoMSKVMd6qiLVSq3L9jwnyb5KBkHVvu6XiV0QCXUkYmh
         NiA9OO+dGtdK2nQyIgWmxBQZl26C+LKp4Rz/5+xHjfJXQvsxA4684myXPPz8GltyhAdD
         jES/WbzmykJweBoGm0+AyByt64KZZf+4jQXLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bOuqSOUJKTCtLFfGL8q6bQX2zd8Q0exNSLGKXWbNEyE3RLVYR0p91NN4Tp2k5Y2sf4
         R+mcpLGJkmKBRCcILj2JQRY+T0FuY4eObpE9Dzma7bfpjltPFQOBVEJ4Qyni8pJ6TduB
         ZYKBHOv2kJ+JQYoN33WbHlnxRlfwNS37/cr1Q=
Received: by 10.100.124.6 with SMTP id w6mr2672366anc.140.1235480687923; Tue, 
	24 Feb 2009 05:04:47 -0800 (PST)
In-Reply-To: <20090224022856.GN4371@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111285>

On Mon, Feb 23, 2009 at 9:28 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:

>> My current solution is to build them on the online box and then copy
>> them over the sneaker net to the offline box.  But, this is kludgey,
>> so not cool. :)
>
> That's just a workaround.

Certainly agree with you there.

> The solution is to have the correct mappings under /etc/xml, so that
> it maps the doctype to /usr/share/xml/docbook/manpages/docbook.xsl,
> or a similar path. After all, ideally your distro does this for you
> automatically. :)

How would I do that?  Unfortunately I have no experience whatsoever
with configuring docbook.  I've always just used a package manager to
install it.  Anyway, there's a `catalog` file in /etc/xml with the
following:

$ cat /etc/xml/catalog
<?xml version="1.0"?>
<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog
V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
  <public publicId="-//OASIS//DTD DocBook XML V4.2//EN"
uri="http://www.oasis-open.org/docbook/xml/4.2/"/>
  <rewriteSystem
systemIdStartString="http://www.oasis-open.org/docbook/xml/4.2/"
rewritePrefix="/usr/share/xml/docbook/4.2/"/>
</catalog>

To my untrained eye there seems to be a local path in there but I have no idea.

Thanks for the help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
