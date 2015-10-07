From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Thu, 08 Oct 2015 00:47:19 +0200
Message-ID: <5615A0F7.9090401@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>		 <1443477738-32023-39-git-send-email-dturner@twopensource.com>		 <56123CE3.9070909@alum.mit.edu>	 <1444181145.7739.70.camel@twopensource.com> <56154194.9050607@alum.mit.edu> <1444251311.8836.22.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:48:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjxVO-0000K0-OQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbJGWrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:47:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44742 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753754AbbJGWr0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 18:47:26 -0400
X-AuditID: 1207440f-f79df6d000007c0f-bc-5615a0f9c08f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B3.E8.31759.9F0A5165; Wed,  7 Oct 2015 18:47:21 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9720C.dip0.t-ipconnect.de [79.201.114.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t97MlJ3H030540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 7 Oct 2015 18:47:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444251311.8836.22.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqPtzgWiYwcN/ChbzN51gtOi60s1k
	0dB7hdmB2ePiJWWPBc/vs3t83iQXwBzFbZOUWFIWnJmep2+XwJ0x6/w0poJenYoLH9+yNjCu
	VO5i5OSQEDCRWD11NzOELSZx4d56ti5GLg4hgcuMEvsn3GaBcM4xSaz6tYUdpIpXQFti3ep2
	JhCbRUBVYuvFPWA2m4CuxKKeZjBbVCBIYsXyF4wQ9YISJ2c+YQGxRYB6Zx/pYQWxmQWsJXb3
	QcSFBXwkula9YYdYtphJYu2rRWDNnAIWEitevmSDaFCX+DPvEjOELS/RvHU28wRGgVlIdsxC
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHhy7+DsWu9zCFG
	AQ5GJR7eH8YiYUKsiWXFlbmHGCU5mJREeX3miYYJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHd
	OR8ox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4A0FxqmQYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCha44uB8QqS4gHaexJsb3FBYi5QFKL1FKOilDjv
	VJCEAEgiozQPbiwsKb1iFAf6Upj3OUgVDzChwXW/AhrMBDS4X14IZHBJIkJKqoFRmet29imm
	uHdfcg8+SZX6cyH58CLOC/8qdaPY2l8IC0lPi/9injzx1mkRyx9Z7Rsir24U3DZvEp+qVPf6
	9LSaV0dufs3/9vDg//WGLqZ3H1+51LQhoPV4S3OlRuG0f+97mn7+ZC4ufRjAZrv6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279208>

On 10/07/2015 10:55 PM, David Turner wrote:
> On Wed, 2015-10-07 at 18:00 +0200, Michael Haggerty wrote:
>>
>> That's a really good point.
>>
>> I hate to break it to you, but the handling of symrefs in Git is already
>> a mess. HEAD is the only symref that I would really trust to work
>> correctly all the time. So I think that changes needn't be judged on
>> whether they handle symrefs perfectly. They should just not break them
>> in any dramatic new ways.
>>
>> So, you pointed out the problem that HEAD (a per-worktree reference) can
>> be a symref that points at a shared reference. In fact, I think when
>> HEAD is symbolic it is only allowed to point at a branch under
>> refs/heads, so this particular problem is pretty well-constrained.
>>
>> Are there other cases of cross-backend writes? I suppose there could be
>> a symref elsewhere among the per-worktree references that points at a
>> shared reference. But I can't think of any cases where this is done by
>> standard Git. Not that it is forbidden; I just don't think it is done by
>> any of the standard tools.
> 
> Another case would be an update-ref command that updates both
> refs/bisect/something and refs/heads/something.  
> 
> I don't think git ever does this by default, but anyone can issue a
> weird update-ref command if they feel like it.

Oh I was mostly worried about symbolic refs reaching across the divide.
If a transaction includes *non-symbolic* refs from both sides I think
all you have to do is sort them into two piles and do one transaction
for each pile. You would probably have to sacrifice atomicity across the
dividing line, but it's a bit unfair to expect atomic updates that span
two possibly completely different backends.

OK, you don't know for 100% sure that a reference is a symref before you
have locked it. But we've agreed that cross-repo symref support doesn't
have to be perfect (except for HEAD).

>> Or there could be a symref among the shared references that points at a
>> per-worktree reference. But AFAIK the only other symrefs that are in
>> common use are the refs/remotes/*/HEAD symrefs, and they always point at
>> references within the same (shared) namespace.
>>
>> If everything that I've said is correct, then my opinion is that it
>> would be perfectly adequate if your code would handle the specific case
>> of HEAD (by hook or by crook), and if there are any other cross-backend
>> symrefs, just die with a message stating that such usage is unsupported.
>> Junio, do you think that would be acceptable?
> 
> Hm.  I don't think it's significantly  easier to handle just HEAD than
> it would be to handle all cases.  But I'll see what happens as I write
> the code.

I think the main simplification is having license not to worry about
shared symrefs that could theoretically point at per-worktree
references. Though I guess that's nonsensical anyway, so maybe it was
already obvious that you don't have to handle it.

>>> The simplest solution would be for the lmdb code to simply acquire
>>> locks, and write to lock files, and then commit those lock files just
>>> before the db transaction commits. Then the lmdb code would handle all
>>> of the orchestration without the files backend having to be rewritten to
>>> handle this case.
>>
>> Wouldn't that essentially be re-implementing the files backend? I must
>> be missing something.
> 
> There would be some amount of reimplementation, yes.  But if we assume
> that the number of per-worktree refs is relatively small, we could make
> some simplification.  But actually, see below.
> 
>>> [...]
>>
>> BTW I just realized that if one backend should delegate to another, then
>> the primary backend should be the per-worktree backend and it should
>> delegate to the common backend. I think I described things the other way
>> around in my earlier message. This makes more sense because it is
>> acceptable for per-worktree references to refer to common references but
>> not vice versa.
> 
> I think I might have a good way to deal with this:
> 
> If we're going to switch the lmdb transaction code over to accumulate
> updates and then do them as one batch, then probably all other
> backends will work the same way.  So maybe there is no need for all of
> these backend functions:
> 
> 	ref_transaction_begin_fn *transaction_begin;
> 	ref_transaction_update_fn *transaction_update;
> 	ref_transaction_create_fn *transaction_create;
> 	ref_transaction_delete_fn *transaction_delete;
> 	ref_transaction_verify_fn *transaction_verify;
> 
> Instead, the generic refs code will accumulate updates in a struct
> ref_update.  Instead of a lock, the ref_update struct will have a void
> pointer that backends can use for per-update data (such as the lock).
> The generic code can also handle rejecting duplicate ref updates.
> 
> The per-backend transaction_commit method will just take a struct
> ref_transaction (that is, what the current patchset calls a
> files_ref_transaction) -- basically, a list of ref_updates -- and
> attempt to apply it.
> 
> While we're doing this, the generic ref code can detect an update to
> HEAD, and replace it with an update to whatever HEAD points to (if HEAD
> is a symref).  Then it can call files_log_ref_write to write to HEAD's
> reflog, if the main transaction commits successfully.  If HEAD is not a
> symref, the generic code can just move the HEAD update over to the files
> backend.
> 
> Does this make sense?

That makes a lot of sense. I like it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
