From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 4/4] Fix ie_match_stat for non-checked-out submodule
Date: Sat, 3 May 2008 07:34:00 +0800
Message-ID: <46dff0320805021634oa7500e8hee004a6e328fd0fa@mail.gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
	 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-5-git-send-email-pkufranky@gmail.com>
	 <7vod7owerk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js4mC-0003Dl-UA
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbYEBXeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 19:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760244AbYEBXeE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:34:04 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:41588 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759933AbYEBXeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 19:34:01 -0400
Received: by an-out-0708.google.com with SMTP id d40so360051and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0qYbtMbjoqXyo0vMQrljg4IpPMCTSkmovqfIPUWdiX0=;
        b=sDE97t9/OfapVkFhUm3eBGdiZgd83ydQbziapnMqeWHU42zR5sgncQIFU2T2Sioxrsmjd8iFszNlKx0DcCuHBz0GhIL9ee1WPNQF7eL6bS7yXSKHxUeVekOaOAE81EDQ4hhKVUFB64l23zOgYTvdRNRIXDPZEpb4JqHg3PQRlLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uj3ir8oDo9TFxcdDau/690l9oQd5wVomGt1TEmxwLWUCVwyo2jH8uA1IdiO1B2RFN3chbU3AimEvo/f7e2K/rC3rquViqA8zwDc/PKFxNE4/qc1iFHz+DcUsSq0asup3yfgYx945BUjWKcbI07g+ak4vl5CfOdAAgRT8G10pZNM=
Received: by 10.100.214.15 with SMTP id m15mr5552261ang.58.1209771240894;
        Fri, 02 May 2008 16:34:00 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 16:34:00 -0700 (PDT)
In-Reply-To: <7vod7owerk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81047>

On Sat, May 3, 2008 at 5:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> --- a/read-cache.c
>  +++ b/read-cache.c
>  @@ -258,6 +258,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>   static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
>   {
>         return (istate->timestamp &&
>  +               !S_ISGITLINK(ce->ce_mode) &&
>                 ((unsigned int)istate->timestamp) <= ce->ce_mtime);
>   }
>

fine



-- 
Ping Yin
