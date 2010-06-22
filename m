From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [PATCH v3] Do not decode url protocol.
Date: Tue, 22 Jun 2010 18:47:39 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C20E92B.1030405@obry.net>
References: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com> <vpq39wf82y3.fsf@bauges.imag.fr>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 22 18:46:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR6ca-0008Ic-MC
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 18:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab0FVQqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 12:46:33 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40464 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab0FVQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 12:46:32 -0400
Received: by wwc33 with SMTP id 33so264991wwc.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=scNm/3D3Qaq/LZBkwXZY2S7RPCahtb29tDOWkH1nMrA=;
        b=rgk2I4dOogrdsDSyMz/NDmCY88oDlTxqikoe5cU5+Q5TdyrDCzAZA63HF6dZoQsF15
         j+UDyoo4+niTJLflUCf++RMPem8+omJSNzHaWtsMSixxamzeb0nsVc2cxPlEZB2p1kbd
         OiOFoBPK52v+lw/qloF6t1BKaI22cACf5aZSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=OJi84YoHU81ayxBIw9gE2xNrTypXOu9Iw41kUmASO0yGjLf3AYXbHGdVnGRo5MwKba
         2gf1h3O+tXitwoUMbfTSkp2reslCt8hFE88ALrjaGCDoaPgyp8I1wYPKmAA8t+H07zip
         sfEuSe3i76cq0xEVIit2tUoRS1CSfPj1JVIkY=
Received: by 10.227.144.146 with SMTP id z18mr6567547wbu.131.1277225190857;
        Tue, 22 Jun 2010 09:46:30 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-11-160.w82-124.abo.wanadoo.fr [82.124.73.160])
        by mx.google.com with ESMTPS id w18sm4732000weq.19.2010.06.22.09.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 09:46:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <vpq39wf82y3.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149484>

Matthieu,

> Unless I missed something, this version doesn't address my earlier
> comment:

Because I do not agree. The three procedures:

char *url_decode(const char *url)
char *url_decode_parameter_name(const char **query)
char *url_decode_parameter_value(const char **query)

are all passed a full url (with protocol). We do not want to decode the
protocol in all three cases. The difference is only that the later two
are stopping the decoding at a given point in the url.

So to me, until I'm proved to be wrong, I think that v3 of my path is
correct.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
