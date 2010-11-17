From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Wed, 17 Nov 2010 14:15:09 -0600
Message-ID: <20101117201509.GA27452@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-5-git-send-email-avarab@gmail.com>
 <7vzkt7enfn.fsf@alter.siamese.dyndns.org>
 <AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 21:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIoQB-00036v-AX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 21:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874Ab0KQUPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 15:15:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53783 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0KQUPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 15:15:54 -0500
Received: by fxm6 with SMTP id 6so925517fxm.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=v36ygh0kn5gGo7o3QKE8YKTisPgjlzj3OCbjJAj+eA4=;
        b=omgkw4a7cPQ19Cn3TFrhoQ/d6/ppe3Re7PC0DHFo7z8OJbU7ZSdive/x3X3eWbDvXm
         6Ioe128XnQDhAeHELMHfhv67XKNB7eg67hi7c4Z6JXBX/Fw6pGrd6DnlkaOtPj9tlX83
         gS5NlTfMp6Z3pyTGrS39XtfPMGgy/HlrO4e28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Jss9hA1DfO7u2ZOODuGaMQ0wwyfKfi+RcbLDFEAC8UHq9hycrvYvrZqaEWEo479qYK
         U2TeWSdcqkMmwzuTaJoQV1gINKHvi8dpEIVJE2nP841RuCV/339zLRLDTterdqD1gVEk
         qMIHvE+1+LVjcsGMu3jv1SQoT27D2hf8lf/Lc=
Received: by 10.223.78.199 with SMTP id m7mr7402925fak.11.1290024952709;
        Wed, 17 Nov 2010 12:15:52 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y1sm1304222fak.39.2010.11.17.12.15.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 12:15:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161634>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I can do that too. I just got the impression previously that we wante=
d
> to only include things in headers that made sense according to their
> name. Gettext has nothing to do with the cache, and cache.h itself
> doesn't need it.

A little bit of history: git was once called dircache.  cache.h is
practically speaking git.h, which is why it declares:

 - get_git_dir
 - ALLOC_GROW
 - zlib_compression_level
 - safe_crlf
 - mksnpath
 - git_pathdup
 - hashclr
 - validate_headref
 - peel_to_type
 - approxidate_careful
 - packed_git
 - path_match
 - fsync_or_die
 - setup_pager
 - checkout_fast_forward

to list a random assortment.  See "A birds-eye view of Git's source
code" in the user manual for more on this.
