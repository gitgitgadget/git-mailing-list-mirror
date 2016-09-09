Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015441F859
	for <e@80x24.org>; Fri,  9 Sep 2016 09:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbcIIJpY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 05:45:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:59195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932088AbcIIJpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 05:45:20 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldcv0-1bHFHx0qaQ-00ioN7; Fri, 09 Sep 2016 11:45:03
 +0200
Date:   Fri, 9 Sep 2016 11:45:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Introduce a function to run regexec() on
 non-NUL-terminated buffers
In-Reply-To: <20160908080447.adquu2e5d7bbeorn@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091140420.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de> <94ee698b2736929d37640012a1b1735b134dd3d6.1473319844.git.johannes.schindelin@gmx.de> <20160908080447.adquu2e5d7bbeorn@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Efh1PPHiDBLN2WA+G/Pc69crAUscOsN0UJqPUiSAlyCVMIIbxZk
 0Yugr9iqoJxjQAKRwa2v81WaluOI4qamISUtPreioxogqP7KqT3FnESyLb7vpMrIrTIcwEh
 /eGrQBff8hEC75zlpVj/csG6bQy5ml/RqgaBiEyLXusXLIm/6xkEmQvrN23OAslhgwJAHQg
 ca5IpJhUOT7KbF6rsgb8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5NQVRTbbc64=:V/EcFYvuf8smqaelRUkZqk
 4V0vSsm7qqd0NwarDNnO4Hd728of3x7W8KQKuGfw0ZqZUVeLOPxk1y3WproD8+rruTFE10Nz+
 1DbLbF7yHZRtThZLTSxTz6EaOFgP4DmN7jVBuLjOMN3OWbQ/lFsdx8X+ak9UJYC4p6i4OUVLi
 Fx83ZiUbTOljkiKatzgN2pDXYr3mo9QHO42dhVrri7jpQgdiRRc1qlMSlfDCSDSbNJvY8v3S3
 e9u31uEjweK0p9lTHSvzzX/a4cOResJ7JGQxOXT4sXHvrEqJ5bRdkEXnQr8+0+u30Xdt9AnjG
 oQq3Evl5xELmb1pskhHrhoGTJCv1g61GFD38GXz8dJtvPtJBGhODq9l1fO8YRm+UTvNrXUNkQ
 LEFIg15XWzQ79o2f+rWR161XhR4uvrwSynaJPBcghlCyyB6gOQNUhYW/RV+PDHnxclYVMqqMn
 sfgPcqWRLhBRZy1bhoKD2b1Z7XxEhqxlIgF5n37D7SvKOztNKgfdj4HoWuhluNr/6xMECqhPC
 y+6Rx/pU069vsBSWiXFBw2/jRTyYB3bl+jJytMdMlloQ5Az3hCIMizOjvxXA9LrIuVUUAqSgv
 irNjfPD7zrwBvONtxzFEE/b0PBG9CcdlIdNiBjiC5MwNym3yA089Df3CMmyCR521k4koYQSOs
 QDo08ncK0rk2mlBdLlB4/aZUtNtwqct8RIKZ34rND5IyN9zfDT9Yo2OjDTCrSZpQ099DbT7uH
 ykX/aqBiQDw2HxP0rNo/QipAF5OZCqdFbw6NoXnyXMeot8jR7DBi7cMxy8L/b47/d/WuxkPMa
 gpQGHDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 8 Sep 2016, Jeff King wrote:

> On Thu, Sep 08, 2016 at 09:31:11AM +0200, Johannes Schindelin wrote:
> 
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index db89ba7..19128b3 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -965,6 +965,27 @@ void git_qsort(void *base, size_t nmemb, size_t size,
> >  #define qsort git_qsort
> >  #endif
> >  
> > +static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> > +			      size_t nmatch, regmatch_t pmatch[], int eflags)
> > +{
> > +#ifdef REG_STARTEND
> > +	assert(nmatch > 0 && pmatch);
> > +	pmatch[0].rm_so = 0;
> > +	pmatch[0].rm_eo = size;
> > +	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
> > +#else
> > +	char *buf2 = xmalloc(size + 1);
> > +	int ret;
> > +
> > +	memcpy(buf2, buf, size);
> > +	buf2[size] = '\0';
> 
> I mentioned elsewhere that I'd prefer we just push people into using
> compat/regex if they don't have REG_STARTEND. But if we _do_ keep this
> fallback, note that the above has a buffer overflow (think what happens
> when "size" is the maximum value for a size_t).  You can avoid it by
> using xmallocz().

That buffer overflow does not exist: If size were the maximum value for
size_t, then buf->ptr would point at a buffer that occupies the entire
available memory, meaning that there is no space left for buf->ptr, let
alone for buf.

But I get your point. It is better to be consistent and use the same logic
for *all* allocations.

Ciao,
Dscho
