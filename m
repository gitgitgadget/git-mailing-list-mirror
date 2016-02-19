From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/20] rename_tmp_log(): use raceproof_create_file()
Date: Fri, 19 Feb 2016 17:07:58 +0100
Message-ID: <56C73DDE.1040606@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
 <a19192cb3219de9304af7d9b97be45a5e6f0895f.1455626201.git.mhagger@alum.mit.edu>
 <xmqqmvqzhxdf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 17:15:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWniO-0004P0-R6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 17:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992856AbcBSQPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 11:15:24 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46043 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992811AbcBSQPR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 11:15:17 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2016 11:15:17 EST
X-AuditID: 12074413-eefff7000000516b-51-56c73de2d2fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 75.8F.20843.2ED37C65; Fri, 19 Feb 2016 11:08:02 -0500 (EST)
Received: from [192.168.69.130] (p548D6AA2.dip0.t-ipconnect.de [84.141.106.162])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1JG7wD2009678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 19 Feb 2016 11:08:00 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <xmqqmvqzhxdf.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqPvI9niYwdofShbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLX609DA7sHk83T6F2ePF+QqPZ717GD0uXlL2WPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZB471Mxbc0Ky4secLewNjk2IXIyeHhICJxIqjN9m6GLk4hAS2Mkrc
	+PqIFSQhJHCBSaLriWkXIweHsICHxPF+CZCwiICaxMS2QywQ9TsZJVY0b2IFcZgFNjBKNDc1
	gDWzCehKLOppZoLYICfR2z2JBcTmFdCWONr4nhHEZhFQlVh37D8biC0qECLx/utzVogaQYmT
	M5+A1XMKWEtcX9kANodZQE9ix/VfrBC2vETz1tnMExgFZiFpmYWkbBaSsgWMzKsY5RJzSnN1
	cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQsJeeAfjrpNyhxgFOBiVeHgvGBwLE2JNLCuu
	zD3EKMnBpCTK22F1PEyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO97I6Acb0piZVVqUT5MSpqD
	RUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC95MNUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFq
	XkpqUWJpSUY8KFbji4HRCpLiAdp7EaSdt7ggMRcoCtF6ilFRSpx3K0hCACSRUZoHNxaWzF4x
	igN9Kcw7A6SKB5gI4bpfAQ1mAhp8b9oxkMEliQgpqQZGu/dzbOIyOjWbVgW6rpKyPptqK9Jj
	58ixmefi/Ls6h0r7k9bIOaef/SR6qklwU9Wv/tW/5AzVCgTqrq3SfC3FW9c8Sey+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286716>

On 02/17/2016 09:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Besides shortening the code, this saves an unnecessary call to
>> safe_create_leading_directories_const() in almost all cases.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs/files-backend.c | 76 ++++++++++++++++++++++------------------------------
>>  1 file changed, 32 insertions(+), 44 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index a549942..e5f964c 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2400,55 +2400,43 @@ out:
>>   */
>>  #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
>>  
>> +static int rename_tmp_log_callback(const char *path, void *cb)
>> +{
>> +	int *true_errno = cb;
>> +
>> +	if (rename(git_path(TMP_RENAMED_LOG), path)) {
>> +		/*
>> +		 * rename(a, b) when b is an existing directory ought
>> +		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
>> +		 * Sheesh. Record the true errno for error reporting,
>> +		 * but report EISDIR to raceproof_create_file() so
>> +		 * that it knows to retry.
>> +		 */
>> +		*true_errno = errno;
>> +		if (errno==ENOTDIR)
>> +			errno = EISDIR;
> 
> Style: SP on both sides of a binary operator.

Thanks; will fix.

> More importantly, is ENOTDIR expected only on a buggy platform?  

Here I was just mimicking the old behavior, which I think was correct,
but let's check more carefully...

> [ENOTDIR]
>     A component of either path prefix names an existing file that is
>     neither a directory nor a symbolic link to a directory; or the old
>     argument names a directory and the new argument names a
>     non-directory file; or the old argument contains at least one non-
>     <slash> character and ends with one or more trailing <slash>
>     characters and the last pathname component names an existing file
>     that is neither a directory nor a symbolic link to a directory; or
>     the old argument names an existing non-directory file and the new
>     argument names a nonexistent file, contains at least one non-
>     <slash> character, and ends with one or more trailing <slash>
>     characters; or the new argument names an existing non-directory
>     file, contains at least one non- <slash> character, and ends with
>     one or more trailing <slash> characters.
> 
> i.e. when a leading component of "path" or TMP_RENAMED_LOG is an
> existing non-directory, we could get ENOTDIR on a valid system.
> 
> If another instance of Git created a file A/B when this process is
> trying to rename the temporary thing to its final location A/B/C,
> isn't that the errno we would see here?
>
> [EISDIR]
>     The new argument points to a directory and the old argument
>     points to a file that is not a directory.
>
> Puzzled...

We just created TMP_RENAMED_LOG ourselves, so I don't think we need to
expect errors from that argument. (Though I don't recall that there is
any locking to prevent two `git branch -m` processes from clobbering
each others' temporary files. Oh well; renaming branches is relatively
rare and probably interactive, so I'll declare that potential problem to
be out of scope for this patch series.)

So let's consider the cases where we can get ENOTDIR for `path`:

> A component of either path prefix names an existing file that is
> neither a directory nor a symbolic link to a directory.

This can certainly happen for `path`, but it is not a case that can be
rescued by raceproof_create_file().

> or the old argument names a directory [...]

This is not the case.

> or the old argument contains [...]

Also not interesting.

> or the old argument names an existing non-directory file and the new
> argument names a nonexistent file, contains at least one non-
> <slash> character, and ends with one or more trailing <slash>
> characters

The new argument doesn't end with trailing <slash> characters, so this
can't happen.

> or the new argument names an existing non-directory
> file, contains at least one non- <slash> character, and ends with
> one or more trailing <slash> characters

Ditto.

So while it is true that a non-buggy implementation can give ENOTDIR, it
is for a case that we can't rescue. So if it weren't for the buggy
implementation, we could just leave ENOTDIR un-handled.

Now, we have to consider the opposite case, namely that we are calling a
non-buggy implementation of `rename()`, and we artificially change
ENOTDIR to EISDIR. Can that cause any bad effects?

I don't think so, because the case where a non-buggy implementation can
yield ENOTDIR is a case, the consequent call to
`remove_dir_recursively()` would fail with ENOTDIR too, and
`raceproof_create_file()` would give up immediately.

So I think everything is OK, though I admit that it is not especially
elegant. We could limit ourselves to doing the workaround only on
Solaris 5.8, but that seems like a lot of effort for not much benefit.
Or we could drop the workaround; after all, Solaris 5.8 was released in
2000 and end-of-lifed in 2012. (Though I don't know whether the behavior
was fixed in later versions of Solaris.)

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
