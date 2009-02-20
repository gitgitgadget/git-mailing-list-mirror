From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC 2/2] gitweb: Hyperlink multiple git hashes on the same commit message line
Date: Fri, 20 Feb 2009 12:46:57 +0100
Message-ID: <200902201247.00670.jnareb@gmail.com>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <200902182255.13983.jnareb@gmail.com> <7v4oypfqua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	fg@one2team.net, giuseppe.bilotta@gmail.com, pasky@suse.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 12:47:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaTqh-00089z-Ob
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 12:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZBTLpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 06:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbZBTLpv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 06:45:51 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63783 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZBTLpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 06:45:50 -0500
Received: by bwz5 with SMTP id 5so2408545bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8cvWelRDfM06fduwaxKamXNy1xCBu8acssdey+EFafE=;
        b=KoiRUsHDlgetYFjm05P7KHQ+jSYFrwa0MYARqmHi2D+Oz+NDfH+r5nw3He2jHorDsS
         /9zzGv/2dPW2HFN0H5Gl9RohvmcSo5aebl0M5fOfLJiKcUt5B0MijGnWJVVW+zQ1qnfw
         TBDdfFDo6pDyTTW7VPKcasuK9IRcDKLoxs2CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IER5+oqeKgrJS7EFSFnCh8Kk34sOfqIrtmNXZ/SqYaAGyKJFE8OCxNaev6xbLffaiE
         daVYWM2msXuO797EVT2ODYRGV7KcNb7HlJWFaIieTUsGhHQeI6p1v0RDSPAb45QpI/Hw
         e5fg8nwjKCSO+L6zhqUOmVtfTGl9/HHMvpLkM=
Received: by 10.103.165.18 with SMTP id s18mr1509849muo.124.1235130348787;
        Fri, 20 Feb 2009 03:45:48 -0800 (PST)
Received: from ?192.168.1.13? (abvl165.neoplus.adsl.tpnet.pl [83.8.209.165])
        by mx.google.com with ESMTPS id u9sm637699muf.55.2009.02.20.03.45.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 03:45:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4oypfqua.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110839>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> +	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> >> +		return $cgi->a({-href => href(action=>"object", hash=>$1),
> >> +					   -class => "text"}, $1);
> >> +	}eg;
> >> +
> >
> > Almost correct... but for this unnecessary 'return' statement.
> > Without it: ACK.
> 
> I've applied this directly on 'master' without the return from inside s///e
> with your Ack.  Please check the result.

I did quick test by installing newest gitweb (with above commit applied),
doing in gitweb searching commit message for '[a-f0-9]{8,40}' with regexp
search; everything looks all right.  But I didn't do extensive tests.

-- 
Jakub Narebski
Poland
