From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 19:48:37 -0500
Organization: Twitter
Message-ID: <1449881317.1678.8.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-3-git-send-email-dturner@twopensource.com>
	 <xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
	 <1449877765.1678.2.camel@twopensource.com>
	 <xmqqegescy6y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 01:48:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7YMf-0005ez-AP
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 01:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbbLLAsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 19:48:41 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34453 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbLLAsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 19:48:40 -0500
Received: by qgz52 with SMTP id 52so23140723qgz.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=KEJuaRBInac7A6WS59rBVbPRP0AyXl1k6w955BpLBEo=;
        b=XLkJKT/F2d2Zwcleo5o/WaWzvZHFo4drRuVGH24OitEeLdqL2kwU5teboOic8Qsrtj
         ND7O3cobveHJjjIR6VA+x5UkcQiTsE3NNoHF+5TGRHUMVGvw5vRLC3W7/iryYBJr+MT3
         ZxEmSq/NtCUYHsZkAP4ulN0LZ5UaiHqLVVaX8OnqgFYaEVhY4EzzgH1/k+tiXZEL2Yd2
         Eq7OSAihmbXsE/ow50DgJfr4X3obQRSgGTs5g16vsIWKUqGsZr4Bf869mevNRQClTZ1+
         DZTo3+BHe3xMFFKorZKOMuMUJEAsMy5bECY4/i1mw6I7QfECiogdYD3hTjQzgGCMoEn+
         OmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=KEJuaRBInac7A6WS59rBVbPRP0AyXl1k6w955BpLBEo=;
        b=KhtoMC/WBYBxK1L7s7EvysjyBbziH/NYCabWue7WFu+7ibNrqhMGdvnHc0oAuAhcIt
         tw4K2N0ISL6CMxMeWoo+cErVtOW8L+rNthePzagxSvVemhEvHkN+nIEpvqF752P2HtXy
         M8JgWgzrGEBQfbUlFyS57p42rtPXL5aDx6g3igTm63FLokH1qedpgwrQJvGId1hzFtrd
         rI42vSfCET2lMPzAV4Uki11c+CTD2cC4txnWYOtZRFxQpz7bvhJxcWne4BidD3CO956v
         rc9VNtjOcJnVxur21bM/VYOfRkZL2QZF4gVOM5t4CoQSlvf6YWPweSSTAoyE5ks8moXa
         Ahtw==
X-Gm-Message-State: ALoCoQlO0afcyghKMEX5Djb16iEB6tbF588gt7mZNssrOZgqqmeI3d0zvsOyjkG64D7K0wOhfEopiul+O5bvPkol3DdH8fgQoA==
X-Received: by 10.140.81.71 with SMTP id e65mr27222722qgd.27.1449881319667;
        Fri, 11 Dec 2015 16:48:39 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id x129sm9204937qhc.33.2015.12.11.16.48.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 16:48:39 -0800 (PST)
In-Reply-To: <xmqqegescy6y.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282294>

On Fri, 2015-12-11 at 16:23 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > The previous review was here:
> > http://permalink.gmane.org/gmane.comp.version-control.git/279062
> >
> > Michael wrote:
> >> Hmmm, I thought our convention was to define typedefs for functions
> >> themselves, not for the pointer-to-function; e.g.,
> >>
> >>     typedef struct ref_transaction *ref_transaction_begin_fn(struct
> >> strbuf *err);
> >>
> >> (which would require `struct ref_be` to be changed to
> >>
> >>         ref_transaction_begin_fn *transaction_begin;
> >
> > And you agreed.  So I changed it.  Do you want me to change it back?  
> 
> Sorry about that. I was agreeing to my mistaken understanding of
> what was pointed out X-<.
> 
> We do prefer fn(args) over (*fn)(args) and somehow I mixed that up
> with the declaration style.

So I should change it back?
