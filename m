From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 09/21] refs: add method to rename refs
Date: Thu, 11 Feb 2016 10:00:04 +0100
Message-ID: <56BC4D94.4040003@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 10:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTn6w-0008CX-5n
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 10:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbcBKJAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 04:00:19 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64326 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751450AbcBKJAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 04:00:16 -0500
X-AuditID: 1207440c-c0bff70000002d40-9d-56bc4d960467
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 15.D6.11584.69D4CB65; Thu, 11 Feb 2016 04:00:06 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1B904GX000786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 04:00:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-10-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqDvNd0+YwbVdlhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDPWPb/OUnCMo2LChCcsDYzX2LoYOTkkBEwk
	vrT0ANlcHEICWxkltrfvYIZwLjBJvLxxnaWLkYNDWMBW4sa9cpAGEQEHicu7jkLVtDFKTF35
	jxUkwSagK7Gop5kJxOYV0Jb4+GIjI4jNIqAqsfbpQzBbVCBE4v3X56wQNYISJ2c+AZvPKeAp
	sfCHBEiYWUBPYsf1X6wQtrzE9rdzmCcw8s1C0jELSdksJGULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuka6uVmluilppRuYoQEHs8Oxm/rZA4xCnAwKvHw/qjZHSbEmlhWXJl7iFGSg0lJ
	lPeg254wIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8zrZAOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/
	IYH0xJLU7NTUgtQimKwMB4eSBK+ND1CjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlG
	PCjy4ouBsQeS4gHaKwfSzltckJgLFIVoPcWoKCXOawaSEABJZJTmwY2FpZNXjOJAXwrz7gCp
	4gGmIrjuV0CDmYAG7/i+C2RwSSJCSqqBcXF+xLH1kr4SRk1Owo67ddjP/fe4oVmbJxR+po0v
	hu+t591iMXM/ufebA9yuR8V/mhCRkMzbkXZ5qZLCv1MFfza/c+U5uiZ/Y6Tc58mv//w6a3Ty
	gDtv6utmFdOodVtza7zXHZ1W6HFo5y7GHcv7Fhk0fJSoOxqSFua6iE/7z7X/1pob 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285954>

On 02/05/2016 08:44 PM, David Turner wrote:
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c               | 5 +++++
>  refs/files-backend.c | 4 +++-
>  refs/refs-internal.h | 9 +++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> [...]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 5768fee..15fa99c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -67,6 +67,13 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
>  				 each_ref_fn fn, int trim, int flags,
>  				 void *cb_data);
>  
> +/*
> + * Check if the new name does not conflict with any existing refs
> + * (other than possibly the old ref).  Return 0 if the ref can be
> + * renamed to the new name.
> + */
> +int rename_ref_available(const char *oldname, const char *newname);

Thanks for adding a docstring for this function. But this function
already has a declaration later in the file so you should remove one or
the other.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
