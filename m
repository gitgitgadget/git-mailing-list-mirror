From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 01/43] refs.c: create a public version of
 verify_refname_available
Date: Fri, 04 Sep 2015 11:45:50 -0400
Organization: Twitter
Message-ID: <1441381550.25570.27.camel@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	 <1441245313-11907-2-git-send-email-dturner@twopensource.com>
	 <xmqqk2s7gkxj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 17:46:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXtBf-0006cS-M1
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 17:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759885AbbIDPpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 11:45:54 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36767 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759823AbbIDPpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 11:45:54 -0400
Received: by qgx61 with SMTP id 61so19019625qgx.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=bE4af2Ui1UuU2zoj/Stwv/63xL2DAWOGHrzBiKnwdUs=;
        b=keQjncNIqCq6UnvizKD2fuARIx9nMxlKKoTjWTvebWOfg/8eSdFuY8lsmsOc0Zv6Xv
         t8JcY5amPIt6YEa5Miq11Eag0a+msXx7uUIAdZmbFGMkePOwNPIp2c/XSnGC2soo3i5w
         IUgollZD/qizQVksuLgjIz2IO6T270vW6yB9DPL5b1uhmGuQGzdad+sH8E3fTjrcys3q
         I2fRl2mB7n1jRRzeghwSf9+ETYaj1i3pj8Tf3UYhKXmYUjSG1lwYSG0a9EnJdEof0Hvd
         KkfRE24baSQ0P4M+HwRuKrGl8zJXYC9ITIc9Bj1XDIB2rYTpihwiE72YS4D9GSr3PS1j
         yufw==
X-Gm-Message-State: ALoCoQmdSnr2T+OdztfLMOzFKQa5+i40IRMU2LqRzNUNVqu3WVCks+Vhtb58pewNMn06g2Lmdoxk
X-Received: by 10.140.129.11 with SMTP id 11mr6334238qhb.86.1441381553273;
        Fri, 04 Sep 2015 08:45:53 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 38sm1233923qgh.11.2015.09.04.08.45.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 08:45:52 -0700 (PDT)
In-Reply-To: <xmqqk2s7gkxj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277315>

On Thu, 2015-09-03 at 16:08 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > @@ -2827,7 +2831,7 @@ int pack_refs(unsigned int flags)
> >   *
> >   * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
> >   */
> > -static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> > +int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> >  {
> >  	struct ref_dir *packed;
> >  	struct string_list_item *refname;
> 
> An unrelated change (belongs to 2/43) snuk in here?

Fixed, thanks.
