From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 09/11] ref-filter: move code from 'for-each-ref'
Date: Mon, 08 Jun 2015 22:43:25 +0530
Message-ID: <5575CD35.4030705@gmail.com>
References: <1433598496-31287-9-git-send-email-karthik.188@gmail.com> <1433673294-16243-1-git-send-email-karthik.188@gmail.com> <vpq4mmiw2jy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20cB-0003YZ-OX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbFHRNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:13:32 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36639 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbFHRNa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:13:30 -0400
Received: by pabqy3 with SMTP id qy3so101432860pab.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TqCPxQpKAGO+poAj3U3EVxMBpYeG2tXZ8rpO6P9dMWY=;
        b=vH79KHH9qzyJzXgbgpGEQKR3tMolBONYVErLOQS/KWGjBk5sMQU14b0/zFNvZ3uv2/
         aevQ8iSJlvCWrV/eYb2Jgv6EdQKqkH2XWiwDkSIBR6aLBjyi8UHkhW9i5HvjFIvvlFEH
         b2GRcu0VqCI02bE7+V7dPZ1dxawTg7lzYKjAQCyc60h2h1lZ4nJXLl6dLmy3IYlD+Kxo
         HDiq0To47AR2zjbtF88Z+ptsCZZsyhZfUq5r02AxIitoPeyevXmC+sGJwnH+/X606Toe
         xPQeGQX3WESOSty2QKiVcOrM89x9Pr3Ngl1r4dmH1gSQzqeFnn/oxAJlLDKuZJY6qNBL
         6npQ==
X-Received: by 10.67.23.3 with SMTP id hw3mr31983177pad.67.1433783610407;
        Mon, 08 Jun 2015 10:13:30 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ki3sm3136881pdb.74.2015.06.08.10.13.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 10:13:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq4mmiw2jy.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271085>

On 06/08/2015 10:38 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -1129,7 +56,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >
> >       memset(&ref_cbdata, 0, sizeof(ref_cbdata));
> >       ref_cbdata.filter.name_patterns = argv;
> > -    for_each_rawref(ref_filter_handler, &ref_cbdata);
> > +    filter_refs(for_each_rawref, &ref_cbdata);
>
> This seems unrelated from the rest of the patch. And you haven't
> introduced filter_refs yet!
>
That definitely is, this happened after fixing merges I suppose.
Ignore it for now, I'll fix it.

-- 
Regards,
Karthik
