From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] log: add log.follow config option
Date: Thu, 02 Jul 2015 14:43:37 -0400
Organization: Twitter
Message-ID: <1435862617.30946.2.camel@twopensource.com>
References: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
	 <vpq8uazo9y6.fsf@anie.imag.fr>
	 <xmqqvbe37eyy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 20:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAjSd-0002PU-GR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbbGBSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:43:42 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34047 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbbGBSnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:43:40 -0400
Received: by qgii30 with SMTP id i30so37097183qgi.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=GTZOlbhanpvRmUheNBdOa81gLRB5irIss1BEMXY7+Y8=;
        b=iXS8+zmayvtz60LerXBJWx6z3r74i1xvCbBPOqNWpqEaeGK+YxZCUj+t0llyAzSuBA
         1C/rYCoUAczSSDcnTyr1Um9Np4banwgejP35HIT0/i4JBlSDgy3CEqn4PGHSUqGgMelf
         yCfMnIECgAGRMKZzWEMHTycQ/gIMWpXLW7jo3Rsev0Ak52xN12fGMuIL5BfmG2vpG6af
         ywttj1xjI0ng0nH+hl4CgNWAvotZsIu1R9lDeRcpmPT+elWpi/tCNvHYVYNLCNZPg968
         MhZJJz9+xMDqM7YV0k9Qi+vuSPXdmW680e8e3D69nbnnsqR5oeRzZZuTOqHwa4glhthU
         Wnhw==
X-Gm-Message-State: ALoCoQkfNu9T+o38tCUQUCRN8LKAZpyCBOP+m0qnLgBpaK4SoFsygGC02PcA2mVLiMJCd9sZigHX
X-Received: by 10.55.18.27 with SMTP id c27mr67347972qkh.84.1435862620072;
        Thu, 02 Jul 2015 11:43:40 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id w68sm3164859qge.18.2015.07.02.11.43.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2015 11:43:39 -0700 (PDT)
In-Reply-To: <xmqqvbe37eyy.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273268>

On Wed, 2015-07-01 at 14:19 -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > So activating --follow for all "git log" calls would prevent log from
> > being used with several pathspecs.
> >
> > Or, do you have a preparation patch that allows --follow with multiple
> > pathspecs? ;-)
> >
> > In any case, you have to test "git log -- path1 path2" with the option
> > activated.
> 
> Or more commonly, just "git log" with no pathspec.
> 
> I also think that it is a bad idea to force "log --follow" to people
> before it is made into a true feature; as it stands, it is merely a
> "checkbox" item.  It has too severe limitation to be used seriously
> in real projects, unless your history is completely linear.
> 
> cf.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/269357/focus=269433

Thanks.

Twitter's history is almost completely linear, so it's useful for us.  

Since it looks like the patch won't be useful outside of our context,
I'll just rewrite it to check the pathspec count, and not upstream it
until follow becomes more general.
