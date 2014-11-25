From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/6] repack_without_refs(): make the refnames argument
 a string_list
Date: Tue, 25 Nov 2014 08:42:13 +0100
Message-ID: <547432D5.8070802@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu> <1416578950-23210-5-git-send-email-mhagger@alum.mit.edu> <20141122211722.GD15320@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 08:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtAsR-0008GD-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 08:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbaKYHt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 02:49:27 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58736 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086AbaKYHtX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 02:49:23 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2014 02:49:23 EST
X-AuditID: 12074412-f79e46d0000036b4-4a-547432d75ed1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BB.2E.14004.7D234745; Tue, 25 Nov 2014 02:42:15 -0500 (EST)
Received: from [192.168.69.130] (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP7gDjx027056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 02:42:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141122211722.GD15320@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqHvdqCTE4NMrHYuuK91MFg29V5gt
	3t5cwmjxb0KNxebN7SwOrB47Z91l91iwqdTj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M1pf
	3mYsuCVSsXT9XbYGxsUCXYycHBICJhI7JrSwQthiEhfurWfrYuTiEBK4zCjx/flZKOcck8Tb
	z99ZQKp4BbQlTh2+wAxiswioStw9tYARxGYT0JVY1NPMBGKLCgRJnNxznR2iXlDi5MwnYL0i
	AhoSzz99AxvKLNDPKDHx3yugIg4OYYEoiaPT8yCWXWeU6Nr1lQkkzilgILGz1Rakl1lAT2LH
	9V+sELa8RPPW2cwTGAVmIVkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunl
	ZpbopaaUbmKEhLXQDsb1J+UOMQpwMCrx8DYcKw4RYk0sK67MPcQoycGkJMorYlgSIsSXlJ9S
	mZFYnBFfVJqTWnyIUYKDWUmEN2oeUDlvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILU
	IpisDAeHkgTvI5ChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdo
	rwdIO29xQWIuUBSi9RSjopQ473eQhABIIqM0D24sLFm9YhQH+lKYNxKkigeY6OC6XwENZgIa
	HDezEGRwSSJCSqqBsX1DcsbblxNit95Isd2gs3a3WUjS5M8HZpTv9LpUPfmIdZFo/m4rsS9V
	JabN8ec1D3/xmzRrVt+kYq1Jk9c2huWG9U58umpjs07QnSi9mC5Xt32y4YwO8y4k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260198>

On 11/22/2014 10:17 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> All of the callers have string_lists available already
> 
> Technically ref_transaction_commit doesn't, but that doesn't matter.

You're right. I'll correct this.

>> Suggested-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/remote.c | 14 ++------------
>>  refs.c           | 38 ++++++++++++++++++++------------------
>>  refs.h           | 11 ++++++++++-
>>  3 files changed, 32 insertions(+), 31 deletions(-)
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> One (optional) nit at the bottom of this message.
> 
> [...]
>> +++ b/refs.c
>> @@ -2639,22 +2639,25 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>>  	return 0;
>>  }
>>  
>> -int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>> +int repack_without_refs(struct string_list *refnames, struct strbuf *err)
>>  {
>>  	struct ref_dir *packed;
>>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>> -	struct string_list_item *ref_to_delete;
>> -	int i, ret, removed = 0;
>> +	struct string_list_item *refname, *ref_to_delete;
>> +	int ret, needs_repacking = 0, removed = 0;
>>  
>>  	assert(err);
>>  
>>  	/* Look for a packed ref */
>> -	for (i = 0; i < n; i++)
>> -		if (get_packed_ref(refnames[i]))
>> +	for_each_string_list_item(refname, refnames) {
>> +		if (get_packed_ref(refname->string)) {
>> +			needs_repacking = 1;
>>  			break;
>> +		}
>> +	}
>>  
>>  	/* Avoid locking if we have nothing to do */
>> -	if (i == n)
>> +	if (!needs_repacking)
> 
> This makes me wish C supported something like Python's for/else
> construct.  Oh well. :)

Ahhh, Python, where arrays of strings *are* string_lists :-)

> [...]
>> +++ b/refs.h
>> @@ -163,7 +163,16 @@ extern void rollback_packed_refs(void);
>>   */
>>  int pack_refs(unsigned int flags);
>>  
>> -extern int repack_without_refs(const char **refnames, int n,
>> +/*
>> + * Remove the refs listed in 'refnames' from the packed-refs file.
>> + * On error, packed-refs will be unchanged, the return value is
>> + * nonzero, and a message about the error is written to the 'err'
>> + * strbuf.
>> + *
>> + * The refs in 'refnames' needn't be sorted. The err buffer must not be
>> + * omitted.
> 
> (nit)
> 
> s/buffer/strbuf/, or s/The err buffer/'err'/
> s/omitted/NULL/

I will fix this too (and improve the docstring a bit in general). Thanks
for your careful review!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
