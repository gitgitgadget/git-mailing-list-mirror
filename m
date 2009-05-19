From: Michael Radziej <mir@noris.de>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log
	--graph
Date: Tue, 19 May 2009 16:09:20 +0200
Message-ID: <20090519140920.GF28702@noris.de>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com> <20090519102742.GA28702@noris.de> <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com> <20090519110800.GB28702@noris.de> <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com> <20090519131044.GD28702@noris.de> <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com> <20090519133947.GE28702@noris.de> <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 16:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Q0Y-00072O-1y
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 16:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZESOJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 10:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbZESOJV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 10:09:21 -0400
Received: from mail03.noris.net ([62.128.1.223]:37843 "EHLO mail03.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbZESOJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 10:09:20 -0400
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail03.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6Q0P-0007sD-11; Tue, 19 May 2009 16:09:21 +0200
Received: from mir.office.noris.de ([10.2.6.66] ident=postfix)
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6Q0O-0001Ju-WC; Tue, 19 May 2009 16:09:21 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id E14951179054; Tue, 19 May 2009 16:09:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119532>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, Bert Wesarg wrote:

> No its just a formating tab to make the output of summary --graphviz ni=
cer ;-)
>=20
> As martin suggests, you can remove any "\t" from the 'echo' lines in
> tg-summary or add a '-e' option to it.
>=20
> I will probably post tomorrow an updated patch.

Cool. If I had any knowledge of graphviz I'd really like to help out :-(

I see another issue. On a quite complicated repository, I did the "tg
summary --graphviz ... edit ...  graphviz ..." dance, and there I get the
following output:

mir@mir:otrs-git$ cat /tmp/graph | gvpr -f ~/src/topgit/share/graph.gvpr
gvpr: "/home/mir/src/topgit/share/graph.gvpr", line 936: gg_nl_ret +=3D
graph_output_commit_line();<<<
 -- cannot convert node_t to string

I have attached /tmp/graph (the output of tg summary --graphviz), I can't
find anything that would stick out. I have to prepare this particular
project a bit before I could push it out to git hub (removing configurati=
on
part with not-so-public content), do you need it at all?

I'm going to be away from mail for a few hours.


Thanks for your efforts!

Michael


--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 17689

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="graph.U9OFCo"

# GraphViz output; pipe to:
#   | dot -Tpng -o <ouput>
# or
#   | dot -Txlib

digraph G {

	graph [
		rankdir = "TB"
		label="TopGit Layout\n\n\n"
		fontsize = 14
		labelloc=top
		pad = "0.5,0.5"
	];

"t/AgentLinkObject-permissions" -> "patchbase";
"t/AgentTicketForward-quoting" -> "patchbase";
"t/FilterTextTicket" -> "patchbase";
"t/TicketCreate-with-TimeStamp" -> "patchbase";
"t/acl-notowner" -> "patchbase";
"t/add-customer-id-checking" -> "patchbase";
"t/agent-email-in-forward-sender" -> "patchbase";
"t/agent-name-in-sender+noris-followups" -> "t/agent-name-in-sender-v2";
"t/agent-name-in-sender+noris-followups" -> "t/noris-followups";
"t/agent-name-in-sender-v2" -> "patchbase";
"t/agent-notification-from" -> "t/mail-outgoing-envelope-sender";
"t/auth-http-with-ldap" -> "patchbase";
"t/auth-ldap-with-UserSyncLDAPRoles" -> "patchbase";
"t/auto-responses-to-envelope-sender" -> "patchbase";
"t/backport-references-headers" -> "patchbase";
"t/backport-references-headers-conflicts" -> "t/backport-references-headers";
"t/backport-references-headers-conflicts" -> "t/TicketCreate-with-TimeStamp";
"t/backport-references-headers-conflicts" -> "t/escalate-on-freetime";
"t/backport-references-headers-conflicts" -> "t/agent-notification-from";
"t/backport-references-headers-conflicts" -> "t/agent-email-in-forward-sender";
"t/backport-references-headers-conflicts" -> "t/noris-ticket-notowner";
"t/backport-references-headers-conflicts" -> "t/noris-self-ticket+noris-followups";
"t/backport-references-headers-conflicts" -> "t/internal-reply-without-envelope-sender-address";
"t/backport-references-headers-conflicts" -> "t/agent-name-in-sender+noris-followups";
"t/backport-references-headers-conflicts" -> "t/references-headers-for-internal-reply";
"t/backport-references-headers-conflicts" -> "t/bare-localparts+http-customer-backend";
"t/bare-localparts" -> "patchbase";
"t/bare-localparts+http-customer-backend" -> "t/bare-localparts";
"t/bare-localparts+http-customer-backend" -> "t/http-customer-backend";
"t/canned-response-format" -> "patchbase";
"t/clean-subject" -> "patchbase";
"t/clean-subject+ticket-after-subject" -> "t/clean-subject";
"t/clean-subject+ticket-after-subject" -> "t/ticket-after-subject";
"t/codefix-AgentTicketQueue" -> "patchbase";
"t/compose-if-without-to" -> "patchbase";
"t/compose-without-envelope-sender-address" -> "t/mail-outgoing-envelope-sender";
"t/configurable-max-length-in-templates" -> "patchbase";
"t/count-available-tickets" -> "patchbase";
"t/create-ticket-with-tn" -> "t/internal-reply";
"t/db-ticket-number" -> "patchbase";
"t/debian-apache" -> "patchbase";
"t/debian-backup" -> "patchbase";
"t/debian-cron" -> "patchbase";
"t/debian-misc-upstream" -> "patchbase";
"t/debian-noris" -> "t/debian-org";
"t/debian-opt" -> "patchbase";
"t/debian-org" -> "patchbase";
"t/debian-postmaster" -> "patchbase";
"t/default-ticket-type" -> "patchbase";
"t/escalate-on-freetime" -> "patchbase";
"t/escalation-search" -> "patchbase";
"t/event-stateupdate-with-previous-state" -> "patchbase";
"t/favicon" -> "patchbase";
"t/favicon+noris-agent-login" -> "t/favicon";
"t/favicon+noris-agent-login" -> "t/noris-agent-login";
"t/favicon+noris-customer-interface" -> "t/favicon";
"t/favicon+noris-customer-interface" -> "t/noris-customer-interface";
"t/favicon+noris-customer-interface+noris-agent-login" -> "t/favicon";
"t/favicon+noris-customer-interface+noris-agent-login" -> "t/noris-customer-interface";
"t/favicon+noris-customer-interface+noris-agent-login" -> "t/noris-agent-login";
"t/fix-AgentTicketZoom-HighlightColor" -> "patchbase";
"t/fix-CustomerAge-spaces" -> "patchbase";
"t/fix-Layout-CheckMimeType" -> "patchbase";
"t/fix-download-contenttype" -> "patchbase";
"t/fix-encode-convert" -> "patchbase";
"t/fix-new-messages" -> "patchbase";
"t/fix-nostates-sql" -> "patchbase";
"t/fix-search-index" -> "patchbase";
"t/fix-ticket-search" -> "patchbase";
"t/fix-ticketfreetime-with-attachments" -> "t/internal-reply";
"t/forward-as-rfc822" -> "patchbase";
"t/forward-template" -> "patchbase";
"t/freetext-fields-size" -> "patchbase";
"t/http-customer-backend" -> "patchbase";
"t/http-customer-backend+t/agent-name-in-sender-v2" -> "t/http-customer-backend";
"t/http-customer-backend+t/agent-name-in-sender-v2" -> "t/agent-name-in-sender-v2";
"t/http-customer-backend-with-ticket-map" -> "t/http-customer-backend";
"t/internal-reply" -> "t/noris-followups";
"t/internal-reply-without-envelope-sender-address" -> "t/internal-reply";
"t/keep-pending-time" -> "patchbase";
"t/keep-pending-time" -> "t/internal-reply";
"t/links-to-closed-tickets" -> "patchbase";
"t/longer-freetext-fields" -> "patchbase";
"t/longer-queue-names" -> "t/templates-with-config-maxlength";
"t/mail-outgoing-envelope-sender" -> "patchbase";
"t/max-title-length" -> "patchbase";
"t/more-article-actions" -> "patchbase";
"t/more-params-in-AgentTicketEmail" -> "patchbase";
"t/more-params-in-AgentTicketPhone" -> "t/internal-reply";
"t/move-as-nonowner" -> "patchbase";
"t/no-accounted-time" -> "patchbase";
"t/no-autoreply-to-agent" -> "patchbase";
"t/no-autoreply-to-agent+http-customer-backend" -> "t/no-autoreply-to-agent";
"t/no-autoreply-to-agent+http-customer-backend" -> "t/http-customer-backend";
"t/no-cc-with-auto-response" -> "patchbase";
"t/no-redirect-on-close" -> "patchbase";
"t/no-redirect-on-close" -> "t/internal-reply";
"t/no-redirect-on-close" -> "t/parking-states";
"t/no-redirect-on-close" -> "t/backport-references-headers";
"t/no-search-on-link" -> "patchbase";
"t/noris-FilterTextWiki" -> "patchbase";
"t/noris-add-work-time" -> "patchbase";
"t/noris-agent-login" -> "patchbase";
"t/noris-attributes" -> "patchbase";
"t/noris-config" -> "patchbase";
"t/noris-confitems" -> "patchbase";
"t/noris-customer-interface" -> "patchbase";
"t/noris-docushare" -> "patchbase";
"t/noris-followups" -> "t/more-article-actions";
"t/noris-followups" -> "t/mail-outgoing-envelope-sender";
"t/noris-followups" -> "t/more-params-in-AgentTicketEmail";
"t/noris-meine-tickets" -> "t/parking-states";
"t/noris-rt-followups" -> "t/noris-followups";
"t/noris-self-ticket" -> "patchbase";
"t/noris-self-ticket+noris-followups" -> "t/noris-self-ticket";
"t/noris-self-ticket+noris-followups" -> "t/noris-rt-followups";
"t/noris-take" -> "patchbase";
"t/noris-ticket-notowner" -> "t/internal-reply";
"t/noris-translation" -> "patchbase";
"t/noris-treeview" -> "patchbase";
"t/parking-states" -> "patchbase";
"t/queue-by-envelope-recipient" -> "patchbase";
"t/rcs-keywords" -> "patchbase";
"t/recipients-for-replies" -> "t/internal-reply";
"t/references-headers-for-internal-reply" -> "t/internal-reply";
"t/show-last-article" -> "patchbase";
"t/suppress-no-caching-headers" -> "t/internal-reply";
"t/suppress-no-caching-headers" -> "t/parking-states";
"t/suppress-no-caching-headers" -> "t/noris-rt-followups";
"t/templates-with-config-maxlength" -> "patchbase";
"t/testing" -> "patchbase";
"t/testing" -> "t/forward-template";
"t/testing" -> "t/AgentLinkObject-permissions";
"t/testing" -> "t/acl-notowner";
"t/testing" -> "t/debian-apache";
"t/testing" -> "t/debian-backup";
"t/testing" -> "t/debian-cron";
"t/testing" -> "t/debian-misc-upstream";
"t/testing" -> "t/debian-noris";
"t/testing" -> "t/debian-opt";
"t/testing" -> "t/debian-postmaster";
"t/testing" -> "t/default-ticket-type";
"t/testing" -> "t/escalation-search";
"t/testing" -> "t/event-stateupdate-with-previous-state";
"t/testing" -> "t/fix-download-contenttype";
"t/testing" -> "t/fix-encode-convert";
"t/testing" -> "t/fix-nostates-sql";
"t/testing" -> "t/fix-ticket-search";
"t/testing" -> "t/forward-as-rfc822";
"t/testing" -> "t/http-customer-backend+t/agent-name-in-sender-v2";
"t/testing" -> "t/links-to-closed-tickets";
"t/testing" -> "t/move-as-nonowner";
"t/testing" -> "t/no-search-on-link";
"t/testing" -> "t/noris-config";
"t/testing" -> "t/noris-confitems";
"t/testing" -> "t/noris-docushare";
"t/testing" -> "t/noris-meine-tickets";
"t/testing" -> "t/noris-treeview";
"t/testing" -> "t/show-last-article";
"t/testing" -> "t/ticketmailbox-by-queue";
"t/testing" -> "t/workaround-mime-words";
"t/testing" -> "t/noris-take";
"t/testing" -> "t/noris-translation";
"t/testing" -> "t/noris-attributes";
"t/testing" -> "t/auto-responses-to-envelope-sender";
"t/testing" -> "t/ticket-in-localpart";
"t/testing" -> "t/no-cc-with-auto-response";
"t/testing" -> "t/auth-http-with-ldap";
"t/testing" -> "t/backport-references-headers-conflicts";
"t/testing" -> "t/compose-without-envelope-sender-address";
"t/testing" -> "t/noris-add-work-time";
"t/testing" -> "t/no-redirect-on-close";
"t/testing" -> "t/rcs-keywords";
"t/testing" -> "t/ticket-subject-hook+db-ticket-number";
"t/testing" -> "t/fix-search-index";
"t/testing" -> "t/queue-by-envelope-recipient";
"t/testing" -> "t/compose-if-without-to";
"t/testing" -> "t/no-accounted-time";
"t/testing" -> "t/longer-freetext-fields";
"t/testing" -> "t/add-customer-id-checking";
"t/testing" -> "t/auth-ldap-with-UserSyncLDAPRoles";
"t/testing" -> "t/canned-response-format";
"t/testing" -> "t/clean-subject+ticket-after-subject";
"t/testing" -> "t/more-params-in-AgentTicketPhone";
"t/testing" -> "t/fix-new-messages";
"t/testing" -> "t/keep-pending-time";
"t/testing" -> "t/create-ticket-with-tn";
"t/testing" -> "t/FilterTextTicket";
"t/testing" -> "t/noris-FilterTextWiki";
"t/testing" -> "t/suppress-no-caching-headers";
"t/testing" -> "t/bare-localparts";
"t/testing" -> "t/bare-localparts+http-customer-backend";
"t/testing" -> "t/count-available-tickets";
"t/testing" -> "t/recipients-for-replies";
"t/testing" -> "t/no-autoreply-to-agent";
"t/testing" -> "t/no-autoreply-to-agent+http-customer-backend";
"t/testing" -> "t/http-customer-backend-with-ticket-map";
"t/testing" -> "t/fix-CustomerAge-spaces";
"t/testing" -> "t/freetext-fields-size";
"t/testing" -> "t/fix-ticketfreetime-with-attachments";
"t/testing" -> "t/configurable-max-length-in-templates";
"t/testing" -> "t/max-title-length";
"t/testing" -> "t/favicon+noris-customer-interface+noris-agent-login";
"t/testing" -> "t/AgentTicketForward-quoting";
"t/testing" -> "t/fix-AgentTicketZoom-HighlightColor";
"t/testing" -> "t/ticketfreetext-per-queue";
"t/testing" -> "t/fix-Layout-CheckMimeType";
"t/testing" -> "t/longer-queue-names";
"t/ticket-after-subject" -> "patchbase";
"t/ticket-hook-subject" -> "patchbase";
"t/ticket-in-localpart" -> "patchbase";
"t/ticket-subject-hook+db-ticket-number" -> "t/ticket-hook-subject";
"t/ticket-subject-hook+db-ticket-number" -> "t/db-ticket-number";
"t/ticket-subject-hook+db-ticket-number" -> "t/clean-subject";
"t/ticketfreetext-per-queue" -> "t/backport-references-headers-conflicts";
"t/ticketfreetext-per-queue" -> "t/parking-states";
"t/ticketmailbox-by-queue" -> "t/parking-states";
"t/ticketmailbox-by-queue" -> "t/codefix-AgentTicketQueue";
"t/ticketmailbox-by-queue" -> "t/ticketmailbox-sort-array";
"t/ticketmailbox-sort-array" -> "patchbase";
"t/workaround-mime-words" -> "patchbase";
}

--6TrnltStXW4iwmi0--
