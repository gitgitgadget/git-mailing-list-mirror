From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v23 0/25] rs/ref-transaction ("Use ref transactions",
 part 3)
Date: Fri, 17 Oct 2014 01:27:19 +0200
Message-ID: <54405457.1040500@alum.mit.edu>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeuS7-0006YS-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 01:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbaJPX1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 19:27:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:51567 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbaJPX1X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 19:27:23 -0400
X-AuditID: 1207440d-f793e6d000000cb1-ed-54405458a1cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.FF.03249.85450445; Thu, 16 Oct 2014 19:27:20 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1812.dip0.t-ipconnect.de [93.219.24.18])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9GNRJTc010783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 16 Oct 2014 19:27:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141015004522.GD32245@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqBsR4hBisGSfjUXXlW4mi4beK8wW
	b28uYbT4N6HGgcVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8af5d3MBe08
	FZc3zmdtYDzF2cXIySEhYCIxr+UtC4QtJnHh3no2EFtI4DKjxKLd6l2MXED2OSaJT/s3M4Ek
	eAW0JZ5d6gGzWQRUJR5u7mMGsdkEdCUW9TSDxUUFAiQ+dD5ghKgXlDg58wnYAhEBDYnnn76B
	LWAWyJZo/TIPrF5YIFji8ptOdojF+hJfGj+AzeQUMJB4eeU7O0S9nsSO679YIWx5ieats5kn
	MArMQrJiFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICWXe
	HYz/18kcYhTgYFTi4dUItg8RYk0sK67MPcQoycGkJMrL5ekQIsSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmE97kGUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrFgzU
	KFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9jqCtPMWFyTmAkUh
	Wk8xKkqJ8yqBJARAEhmleXBjYQnqFaM40JfCvGIgVTzA5AbX/QpoMBPQ4ImhtiCDSxIRUlIN
	jMnmB3s45vG9u9njnnfg/MJ/Uwsvntg1+3TmSybTL3d5djctd+FLVFvmPe+9afCXix2XOH7K
	Fi4OWOG89IdE5Nvu0mlPD0TL817y+nWXYyL7cd9WRr1wnWkGcmc33QrM5VBP8per 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2014 02:45 AM, Jonathan Nieder wrote:
> This series by Ronnie was last seen on-list at [1].  It includes some
> improvements to the ref-transaction API, improves handling of poorly
> named refs (which should make it easier to tighten the refname format
> checks in the future), and is a stepping stone toward later series
> that use the ref-transaction API more and make it support alternate
> backends (yay!).
> 
> The changes since (a merge of 'master' and) v22 are very minor and can
> be seen below[2].  The more important change is that it's rebased
> against current 'master'.
> 
> Review comments from Michael and Junio were very helpful in getting
> this in shape.  Thanks much to both.
> 
> The series can also be found at
> 
>   git://repo.or.cz/git/jrn.git tags/rs/ref-transaction
> 
> It is based against current 'master' (670a3c1d, 2014-10-14) and
> intended for 'next'.
> 
> Thoughts welcome, as always.  Improvements preferred in the form of
> patches on top of the series.

Thanks for the new version. I reviewed the previous version pretty
carefully in Gerrit and was very happy with the overall series, though
there were still some rough spots. It seems to be much more polished now.

Given that I will be traveling for the next two weeks I probably won't
be able to do another thorough review in time. But I just scanned
through patches 01 - 19 and didn't notice any problems. Unfortunately I
have to stop there.

Cheers,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
