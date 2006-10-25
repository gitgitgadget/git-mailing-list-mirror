X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: "James Henstridge" <james@jamesh.id.au>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 18:08:22 +0800
Message-ID: <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1161770924 4041 80.91.229.2 (25 Oct 2006 10:08:44 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 25 Oct 2006 10:08:44 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 25 12:08:42 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gcfga-0005Ii-5G
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 25 Oct 2006 12:08:36 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GcfgO-0001Ak-QP; Wed, 25 Oct 2006 11:08:24 +0100
Received: from nf-out-0910.google.com ([64.233.182.189])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <james.henstridge@gmail.com>) id 1GcfgN-0001AZ-CS
	for bazaar-ng@lists.canonical.com; Wed, 25 Oct 2006 11:08:23 +0100
Received: by nf-out-0910.google.com with SMTP id l37so548346nfc
	for <bazaar-ng@lists.canonical.com>;
	Wed, 25 Oct 2006 03:08:23 -0700 (PDT)
Received: by 10.82.101.3 with SMTP id y3mr50527bub;
	Wed, 25 Oct 2006 03:08:22 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Wed, 25 Oct 2006 03:08:22 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610251146.06116.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 6ff3f703b7a3c7be
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18749 gmane.comp.version-control.git:30047
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30047>
X-Mailing-List: git@vger.kernel.org

On 25/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Andreas Ericsson wrote:
> > This is new to me. At work, we merge our toy repositories back and forth
> > between devs only. There is no central repo at all. Does this mean that
> > each merge would add one extra commit per time the one I'm merging with
> > has merged with me?
>
> From what I understand, "bzr merge" will create one extra commit to
> preserve the "first parent is my branch" feature. "bzr pull" will do
> fast-forward if your DAG is proper subset of pulled branch/repository
> DAG, but at the cost that it would change your revno to revision mapping
> to those of the pulled repository.

Actually, "bzr merge" does not create any commits on the branch -- you
need to run "bzr commit" afterwards (possibly after resolving
conflicts).  The control files for the working tree record a pending
merge, which gets recorded when you get round to the commit.

So you can easily check if there were any tree changes resulting from the merge.

If there aren't, or you made the merge by mistake, you can make a call
to "bzr revert" to clean things up without ever having created a new
revision.

James.



