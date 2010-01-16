From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Sat, 16 Jan 2010 02:14:55 +0100
Message-ID: <201001160214.58167.jnareb@gmail.com>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <m3ljfydgmt.fsf@localhost.localdomain> <7vmy0eoogx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxG9-0002b8-QO
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429Ab0APBPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758384Ab0APBPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:15:09 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:40803 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab0APBPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:15:06 -0500
Received: by fxm25 with SMTP id 25so731675fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2sTdyiXnlqrraxvNAiuZyjl1ZlSYL5osAoSxvZZA2VQ=;
        b=fwZnZZwkDqZW3RF1a66ojRRrUVGxXJgrCd+L3wVdqXP8I/deXdd7uhUzvlp8aeZwCx
         l4miG6uhlrF6aQbP6ssCktYl9A7WOgyVzRy0PNwgFr4MhERrannRFUTwhu0/aTCdRSH5
         HYX6Eq42tNs/duespG8FgF1hJjWQNaywNHFVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Kc9ZfmJWCnfkl/WyO5crA/GRR+4aN1yfF+FSdylBWy76qHYW15lR01CVDmMmlZhLxY
         KyAZW03LjHwYXFukTk5nLU5GbFrdoB00AoArs05Do+Y97OU0byJh1bWX2/N0XDMyL8nb
         iJQunKPqTFntnHKYhg+8a3uN0amt6dQ13g6c0=
Received: by 10.223.54.15 with SMTP id o15mr3434908fag.96.1263604503833;
        Fri, 15 Jan 2010 17:15:03 -0800 (PST)
Received: from ?192.168.1.13? (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id 16sm565040fxm.8.2010.01.15.17.15.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 17:15:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmy0eoogx.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137187>

On Sat, 16 Jan 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This means replacing
> >
> >   print <something>;
> > by
> >   print {$out} <something>;
> 
> Just out of curiosity, how is this different from
> 
>     print $out <something>;

Actually there is no difference.  It doesn't matter one way or other in
situations in gitweb.

I have thought however (but I might be mistaken) that "print {$fh} <sth>"
is idiomatic Perl.

'perldoc -f print' says:
    Note that if you're storing FILEHANDLES in an array or other expression,
    you will have to use a block returning its value instead:

           print { $files[$i] } "stuff\n";
           print { $OK ? STDOUT : STDERR } "stuff\n";

Also, there is no "," between FILEHANDLE and LIST in "print FILEHANDLE LIST"
-- 
Jakub Narebski
Poland
