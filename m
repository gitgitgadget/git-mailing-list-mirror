From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 22:12:32 +0200
Message-ID: <201004142212.33162.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004142110.36453.jnareb@gmail.com> <7vwrw9q18m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:12:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28wT-0004xk-VX
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab0DNUMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 16:12:03 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:46092 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab0DNUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:12:01 -0400
Received: by bwz25 with SMTP id 25so682368bwz.28
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0QStTxiv1BcLMQbkFUKe4HpmDRw/jjbUWF33zlPTWC0=;
        b=X03JvayfknzbiEywt8hnvaLmiwgrrlGGdRaPM8E50FcF0MVn50KHdlFb/JYMbpnFMY
         BPGTdL3Vu8leUwXXdlEzNAiSBKdYpTrZCor4bYwOx1oT6+olqvKTxgqGF9tDgy6VkwLg
         kUHy1bdfMrBZMYYd2kknSKE9WHF6C/urCaY/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uoLUfKiydbYPrNqNLjYpwP3H+H7Lo3sLKVkf+qDT+ItNyoA5GtzHtqhHLkMzIyapqD
         g86Sgk4rjePxDFaPeCxmv3sGi7MNnucGcwxbTgaAX6apz5KLJl/SADF/UP80aB5blo4e
         KD6b76obRWcValrXk6R0yr4nAxMU352gbQsAQ=
Received: by 10.103.126.36 with SMTP id d36mr4507753mun.65.1271275919372;
        Wed, 14 Apr 2010 13:11:59 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id u26sm4067964mug.25.2010.04.14.13.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 13:11:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrw9q18m.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144902>

Dnia =B6roda 14. kwietnia 2010 21:32, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > I don't think it is needed for either command.
> >
> > 'git blame' has --porcelain and --incremental output, which is line=
-based
> > and pretty much self-describing (with "header-name value" syntax fo=
r most
> > of it), and well documented.  JSON output would only add unnecessar=
y
> > chatter and different quoting rules.
>=20
> Wouldn't the exact same argument apply equally well to the output for=
mat
> of "status --porcelain", by the way?  It is line-based and pretty muc=
h
> self-describing (once you know the mnemonic but you can make an educa=
ted
> guess from previous SCM experience).

No, current "git status --porcelain" output is record-based (tabular);
the meaning is not described by header but depends on field in record,
i.e. position in line.

Self describing output of "git status --porcelain" would be

  filename <maybe-quoted filename>
  renamed-from <maybe-quoted filename>
  similarity 95%
  worktree ...
  index ...

or something like that...

--=20
Jakub Narebski
Poland
