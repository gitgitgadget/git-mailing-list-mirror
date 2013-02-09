From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Permission denied on home dir results in fatal error as of
 1.8.1.1
Date: Fri, 8 Feb 2013 17:05:34 -0800
Message-ID: <20130209010534.GC8461@google.com>
References: <CAECnihxpvtE1XejzHDCRBF=GkyBHmb53WDLa16Suiq=4SeYzvA@mail.gmail.com>
 <7v6222xqc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nick Muerdter <stuff@nickm.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ytO-0006ha-NW
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 02:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368Ab3BIBFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 20:05:41 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:55542 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab3BIBFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 20:05:40 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so2036223daj.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 17:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IlEOyx/ubE2qgeNBXFN8BsuNRfmgTDMcFF/3dnCB6b4=;
        b=H1OBUlUSKXGyElv6/v54xih+WTaeStNuGHN+kcqLDmRpj54oOuPdfEN9eWLVDFzW2k
         ILtwwHNA6myZGYjmv+rErHqv705V2Pv/tlCxN65e7t5XiqJ3Ejqkbh36XVfeip1S/JDq
         LLNCDcrV3mI4fKX84ep/TQHtW7/sALNPO9pngyFMSXSMZKGzYQftFrneHA5yg/PpkHH2
         NPAXzLyVsWl8MIlZyHxAvw9fHTD1M7S2ekOgDKSN2+3QTQMM0+sqTtkEVRaEsgLi1h5E
         Ucj+hizabdVHJ5wZsHCyiOzl5cysrsM7fvLsKRQZd4GMadmuWUFDHwx2CTIsFfOdNjF+
         ACiQ==
X-Received: by 10.66.87.8 with SMTP id t8mr22943719paz.28.1360371939421;
        Fri, 08 Feb 2013 17:05:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id q4sm58501652paz.20.2013.02.08.17.05.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 17:05:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v6222xqc4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215839>

Junio C Hamano wrote:
> Nick Muerdter <stuff@nickm.org> writes:

>> As of git 1.8.1.1 and above (tested up to 1.8.1.3), if the home
>> directory can't be accessed, it results in a fatal error. In git 1.8.1
>> and below this same setup just resulted in warnings. Was this an
>> intentional change?
>
> I think this was done to not just help diagnosing misconfiguration,
> but to prevent an unintended misconfiguration from causing problems
> (e.g. the user thinks user.name is set up correctly, but forbids Git
> from reading it from the configuration files, and ends up creating
> commits under wrong names).

Yes, that's right.  Sometimes ignoring settings has bad consequences,
so git errors out to let the user intervene and decide whether the
inaccessible settings are important.

Thanks,
Jonathan
